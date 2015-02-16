require 'dotenv/tasks'
require 'manifest_uploader'

namespace :manifests do
  desc 'Creates manifest files on the appropriate GitHub repositories'
  task :upload => [:environment, :dotenv] do
    unless ENV.key?('GITHUB_ACCESS_TOKEN')
      puts 'Please set GITHUB_ACCESS_TOKEN environment variable.'
      exit 1
    end

    puts "Reading from STDIN..."

    manifests = JSON.load(STDIN.read)

    client = Octokit::Client.new({
      access_token:  ENV['GITHUB_ACCESS_TOKEN'],
      auto_paginate: true,
      per_page:      100
    })

    repo_names = client.org_repos("codeunion").map(&:name)

    options = { only_fields: %w(category tags notes) }

    manifests.reject { |m| !repo_names.include?(m['name']) }.each do |manifest|
      puts "Uploading manifest to #{manifest['name']}..."
      ManifestUploader.new(client, manifest, options).run
    end
  end
end
