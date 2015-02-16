require 'dotenv/tasks'
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
  end

  desc 'Creates a project, example, or resource'
  task :create, [:url] => [:environment, :dotenv]  do |_, arguments|
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
  task refresh: [:environment, :dotenv] do
    Resource.find_each do |resource|
      loader = ResourceLoader.new(
        resource.url,
        Resource,
        github_public_client
      )

      with_resource_errors(loader) do
        loader.rerieve_and_store
      end
    end
  end
end
