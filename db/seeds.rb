Resource.destroy_all

require 'json'

DATA_DIR = File.expand_path('../init-data', __FILE__)

manifests_file = File.join(DATA_DIR, 'manifests.json')
manifests = JSON.parse( File.read( manifests_file ) )

resources = manifests.map do |manifest|
  begin
    puts "Loading #{manifest['name']}"
    puts ResourceLoader::CLI.new(manifest['url'], manifest['category'], Resource).run
  rescue ResourceLoader::ResourceNotPublic => e
    puts "#{manifest['name']} was not a public resource"
  end
end

Resource.create(resources)
