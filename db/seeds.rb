Resource.destroy_all

require 'json'

DATA_DIR = File.expand_path('../init-data', __FILE__)

manifests_file = File.join(DATA_DIR, 'manifests.json')
readmes_dir = File.join(DATA_DIR, 'readmes')

manifests = JSON.parse( File.read( manifests_file ) )

resources = manifests.map do |manifest|
  readme_file = File.join(readmes_dir, manifest['name'] + '.md')

  readme_text = File.exists?(readme_file) ? File.read(readme_file) : nil

  { name: manifest['name'],
    url: manifest['url'],
    description: manifest['description'],
    category: manifest['category'],
    manifest: manifest,
    readme: readme_text }
end

Resource.create(resources)
