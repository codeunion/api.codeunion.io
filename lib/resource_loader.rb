require 'uri'
require 'base64'
require 'multi_json'

# Loads a resource into a resource storage container.
#
#   > client = Octokit::Client.new(credentials)
#   > resource_url = "https://github.com/codeunion/rpn-calculator"
#   >
#   > loader = ResourceLoader.new(resource_url, Resource, client)
#   => <ResourceLoader @url="...", @resource_storage=Resource, ...>
#   > loader.retrieve_and_store
#   => nil
#   > loader.resource
#   => <Resource id: 10, category: "project", ...>
class ResourceLoader
  # Generic base class for loader-related errors
  class LoaderError < StandardError; end

  # Raised when a given resource is not publicly accessible
  class ResourceNotPublic < LoaderError; end

  # Raised when a given resource doesn't exist or is otherwise inaccessible
  class ResourceNotFound < LoaderError; end

  # Raised when repository has no manifest file
  class ManifestMissing < LoaderError; end

  # Raised when resource shouldn't be indexed
  class ResourceNotIndexable < LoaderError; end

  # @return [Resource, nil]
  #   Resource retrieved by the loader
  attr_reader :resource

  # @return [String]
  #   Returns the URL for the given resource
  attr_reader :url

  # @param url [String]
  #   URL of a resource to load
  # @param resource_storage [#create_or_update_from_manifest]
  #   Must return an
  #   {https://github.com/rails/rails/tree/master/activemodel ActiveModel}
  #   instance.
  # @param client [OctoKit::Client]
  #   Must return an
  #   {https://github.com/octokit/octokit.rb/tree/master OctoKit::Client}
  #   instance.
  #
  # See {Resource.create_or_update_from_manifest}.
  def initialize(url, resource_storage, client)
    @url = url
    @resource_storage = resource_storage
    @client = client
  end

  # Retrieves the project from the web and stores it.
  # @return [nil]
  def retrieve_and_store
    @resource = @resource_storage.create_or_update_from_manifest(manifest)
    nil
  end

  # Loads a publicly available resource and returns a resource manifest
  # @return [Hash]
  #  A resource manifest
  def manifest
    repo_name = url_path[0] == '/' ? url_path[1..-1] : url_path

    GithubRepositoryResource.new(repo_name, @client).to_h
  end

  private

  def url_path
    @url_path ||= URI.parse(url).path
  end

  # Loads a resource from a URL, stores it, and logs output describing what
  # happened.
  class CLI
    # @return [String]
    #   Returns the URL for the given resource
    attr_reader :url

    # (see ResourceLoader#initialize)
    def initialize(url, resource_storage, client)
      @url = url
      @loader = ResourceLoader.new(url, resource_storage, client)
    end

    # Loads resource and returns output about whether it worked.
    # @return [String]
    #   Output from the creation of the resource.
    def run
      @loader.retrieve_and_store
      resource = @loader.resource

      output = []
      if resource.valid?
        output << "Created #{resource.name}"
      else
        output << "Couldn't create #{resource.name} for the following reasons:"
        resource.errors.full_messages.each do |error|
          output << "  * #{error}"
        end
      end
      output.join("\n")
    end

    def resource
      @loader.resource
    end
  end

  # Converts github repositories into a resource manifest
  class GithubRepositoryResource
    # @param full_repo_name [String]
    #   The org-prefixed name of the repository, e.g., +'codeunion/Wall-B'+.
    # @param client [Octokit::Client]
    #   An {https://github.com/octokit/octokit.rb/tree/master OctoKit::Client}
    #   instance used to make calls to the GitHub API.
    def initialize(full_repo_name, client)
      @full_repo_name = full_repo_name
      @org_name, @repo_name = full_repo_name.split('/')
      @client = client
    end

    # Parses the github project website into a resource manifest
    # @return [Hash]
    #   A resource manifest
    def manifest
      fail ResourceNotFound,     "#{full_repo_name} does not exist"    unless repo_exists?
      fail ResourceNotPublic,    "#{full_repo_name} is not public"     unless public?
      fail ManifestMissing,      "#{full_repo_name} has no manifest"   unless manifest_exists?
      fail ResourceNotIndexable, "#{full_repo_name} cannot be indexed" unless indexable?

      @manifest ||= {
        url:         url,
        name:        name,
        category:    category,
        description: description,
        tags:        tags,
        readme:      readme
      }
    end
    alias_method :to_h, :manifest

    # @return [Boolean]
    #   Returns +true+ if the resource repository exists (+false+ otherwise).
    def repo_exists?
      return @_repo_exists unless @_repo_exists.nil?

      @_repo_exists = client.repository?(full_repo_name)
    end

    # @return [Boolean]
    #   Returns +true+ if the resource repository exists and is public (+false+
    #   otherwise).
    def public?
      repo_exists? && !repo.private?
    end

    # @return [Boolean]
    #   Returns +true+ if the resource repository exists and has a manifest
    #   file (+false+ otherwise).
    def manifest_exists?
      return false unless repo_exists?
      return @_manifest_exists unless @_manifest_exists.nil?

      @_manifest_exists = client.contents(full_repo_name).any? do |f|
        f.path == 'manifest.json'
      end
    end

    # @return [Boolean]
    #   Returns +true+ if the repository is indexable and +false+ otherwise.
    def indexable?
      return false unless manifest_exists?

      %w(project example exercise).include?(category)
    end

    private

    attr_reader :full_repo_name, :org_name, :repo_name, :client

    def repo
      @_repo ||= client.repository(full_repo_name)
    end

    def readme
      @_readme ||= content(client.readme(full_repo_name))
    end

    def github_manifest
      @_github_manifest ||= MultiJson.load(
        content(client.contents(full_repo_name, path: 'manifest.json')),
        symbolize_keys: true
      )
    end

    def name
      repo.name
    end

    def description
      repo.description
    end

    def url
      repo.html_url
    end

    def tags
      github_manifest[:tags]
    end

    def category
      github_manifest[:category]
    end

    def content(resource)
      Base64.decode64(resource.content)
    end
  end
end
