require 'octokit'
require 'resource_loader'

namespace :resources do
  def github_public_client
    unless ENV.key?('GITHUB_CLIENT_ID') && ENV.key?('GITHUB_CLIENT_SECRET')
      puts 'Please set GITHUB_CLIENT_ID and GITHUB_CLIENT_SECRET ' \
           'environment variables.'
      exit 1
    end

    @client ||= Octokit::Client.new(
      client_id:     ENV['GITHUB_CLIENT_ID'],
      client_secret: ENV['GITHUB_CLIENT_SECRET']
    )
  end

  def with_resource_errors(object)
    yield
  rescue ResourceLoader::ResourceNotPublic
    puts "[Error] #{object.url} is not public"
  rescue ResourceLoader::ManifestMissing
    puts "[Error] #{object.url} has no manifest"
  rescue ResourceLoader::ResourceNotFound
    puts "[Error] #{object.url} no longer exists"
  rescue ResourceLoader::ResourceNotIndexable
    puts "[Error] #{object.url} cannot be indexed - are you sure you meant " \
         "to add it?"
  end

  desc 'Creates a project, example, or resource'
  task :create, [:url] => :environment do |_, arguments|
    cli = ResourceLoader::CLI.new(
      arguments[:url],
      Resource,
      github_public_client
    )

    with_resource_errors(cli) do
      puts cli.run
    end
  end

  desc 'Refreshes all the resources in the database'
  task refresh: :environment do
    Resource.find_each do |resource|
      puts "Refreshing #{resource.name} from remote manifest..."

      loader = ResourceLoader.new(
        resource.url,
        Resource,
        github_public_client
      )

      with_resource_errors(loader) do
        loader.retrieve_and_store
      end
    end
  end
end
