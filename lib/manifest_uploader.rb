require "uri"
require "json"

class ManifestUploader
  # @param client [Octokit::Client]
  #   An {https://github.com/octokit/octokit.rb Octokit::Client} instance
  # @param manifest [Hash] A resource manifest
  # @param options [Hash] An options +Hash+
  # @option options [String] :manifest_filename
  #   The manifest filename (defaults to +"manifest.json"+).
  # @option options [String] :only_fields
  #   An +Array+ of field names that will be retained in the manifest.  If
  #   nothing is specificed, all fields will be retained.
  def initialize(client, manifest, options = {})
    @client   = client
    @manifest = manifest
    @options  = options
  end

  # Attempts to create the remote manifest if it doesn't exist and update the
  # remote manifest if it differs from the supplied manifest.
  def run
    if !repo_manifest_exists?
      puts "Creating manifest for #{manifest['name']}"
      create_repo_manifest!
    elsif repo_manifest_changed?
      puts "Updating manifest for #{manifest['name']}"
      update_repo_manifest!
    else
      puts "No changes to manifest for #{manifest['name']}, skipping..."
    end
  end

  private

  attr_reader :client, :manifest, :options

  def filtered_manifest
    if options.key?(:only_fields)
      manifest.keep_if { |field, _| options[:only_fields].include?(field) }
    else
      manifest
    end
  end

  def manifest_filename
    @manifest_filename ||= options.fetch(:manifest_filename) { "manifest.json" }
  end

  def manifest_content
    JSON.pretty_generate(filtered_manifest)
  end

  def repo_name
    URI.parse(manifest["url"]).path[1..-1]
  end

  def repo_manifest
    return @repo_manifest if @repo_manifest

    begin
      @repo_manifest = client.contents(repo_name, path: manifest_filename)
    rescue Octokit::NotFound
      nil
    end
  end

  def repo_manifest_content
    return unless repo_manifest_exists?

    @repo_manifest_content ||= Base64.decode64(repo_manifest.content)
  end

  def repo_manifest_exists?
    return @repo_manifest_exists unless @repo_manifest_exists.nil?
    @repo_manifest_exists = !repo_manifest.nil?
  end

  def repo_manifest_changed?
    manifest_content != repo_manifest_content
  end

  def update_repo_manifest!
    sha = repo_manifest.sha
    message = "Updated #{manifest_filename}"
    client.update_contents(repo_name, manifest_filename, message, sha, manifest_content)
  end

  def create_repo_manifest!
    message = "Added #{manifest_filename}"
    client.create_contents(repo_name, manifest_filename, message, manifest_content)
  end
end
