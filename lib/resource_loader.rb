require 'faraday'
require 'reverse_markdown'
require 'nokogiri'

# Loads a resource into a resource storage container.
#
#   > loader = ResourceLoader.new("https://github.com/codeunion/rpn-calculator", "project", Resource)
#   => <ResourceLoader @url="...", @category="proejct", ...>
#   > loader.retrieve_and_store
#   => nil
#   > loader.resource
#   => <Resource id: 10, category: "project", ...>
class ResourceLoader

  # @return [Resource, nil] Resource retrieved by the loader
  attr_reader :resource

  # @param url [String] URL of resource to load
  # @param category [String] Category the resource belongs to
  # @param resource_storage [#create_or_update_from_manifest]
  #   - Must return an {https://github.com/rails/rails/tree/master/activemodel ActiveModel}.
  #   - See {Resource.create_or_update_from_manifest}
  def initialize(url, category, resource_storage)
    @url = url
    @category = category
    @resource_storage = resource_storage
  end

  # Retrieves the project from the web and stores it.
  # @return [nil]
  def retrieve_and_store
    @resource = @resource_storage.create_or_update_from_manifest(manifest)
    nil
  end

  # Loads a publicly available resource and returns a resource manifest
  # @return [Hash] A resource manifest
  def manifest
    response = Faraday.get(@url)
    fail(ResourceNotPublic, @url) unless response.status == 200
    GithubRepositoryResource.new(@url, @category, response.body).to_h
  end

  # Loads a resource from a URL, stores it, and logs output describing what
  # happened.
  class CLI
    # (see ResourceLoader#initialize)
    def initialize(url, category, resource_storage)
      @loader = ResourceLoader.new(url, category, resource_storage)
    end

    # Loads resource and returns output about whether it worked.
    # @return [String] Output from the creation of the resource.
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
  end

  # Converts github repositories into a resource manifest
  class GithubRepositoryResource
    # @param url [String] URL the resource lived at.
    # @param category [String] Which category the resource belongs to
    # @param body [String] HTML of a github repository project home page
    def initialize(url, category, body)
      @url = url
      @category = category
      @body = body
    end

    def to_h
      manifest
    end

    # Parses the github project website into a resource manifest
    # @return [Hash] - resource manifest.
    def manifest
      @manifest ||= {
        :url => url,
        :name => name,
        :category => category,
        :description => description,
        :tags => tags,
        :readme => readme,
      }
    end

    alias_method :to_h, :manifest

    private
    attr_reader :category, :url

    def readme
      @readme ||= ReverseMarkdown.convert(doc.at_css('#readme > article'), { :unknown_tags => :bypass, :github_flavored => true })
    end

    def doc
      @doc ||= Nokogiri::HTML(@body)
    end

    def name
      @name ||= doc.at_css('.js-current-repository').text.strip
    end

    def description
      return @description if @description
      description_node = doc.at_css('.repository-description')
      @description = description_node ? description_node.text.strip : ""
    end

    def tags
      return @tags if @tags
      # Finds the h4 element with the topics-covered text, then finds it's
      # neighboring unordered list.
      tag_nodes = doc.at_xpath('//a[@id="user-content-topics-covered"]/../following-sibling::*')

      @tags = []
      if tag_nodes
        @tags = tag_nodes.css('li').map do |tag_node, b|
          tag_node.text.downcase.gsub(" ", "-")
        end
      end
    end
  end

  # Raised when a given resource is not publicly accessible
  class ResourceNotPublic < StandardError; end
end
