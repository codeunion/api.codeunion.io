# Loads manifests from the file system.
#
#   > loader = ManifestLoader.new(path_to_manifest: "/path/to/manifest.json)
#   => <ManifestLoader @path_to_manifest="...", @extra_manifests=[]>
#   > loader.manifests
#   => [{ :url => "...", :category => "..."}]
class ManifestLoader
  # Path to default data directory
  DATA_DIR = File.expand_path('../../db/init-data', __FILE__)
  # Absolute path to default manifest file.
  MANIFESTS_FILE = File.join(DATA_DIR, 'manifests.json')


  # @param path_to_manifest [String, Pathname] Absolute path to manifest file.
  # @param extra_manifests [Array<Hash>] Extra manifests to include in set of loaded manifests.
  def initialize(path_to_manifest: MANIFESTS_FILE, extra_manifests: [])
    @path_to_manifest = path_to_manifest
    @extra_manifests = extra_manifests
  end

  # Set of unique manifests from manifest file and extras
  # @return [Array<Hash>]
  def manifests
    @manifests ||= JSON.parse(manifest_file).reject do |m|
      @extra_manifests.any? { |e| e['url'] == m['url'] }
    end
  end

  private
  def manifest_file
    @manifest_file ||= File.read(@path_to_manifest)
  end
end
