require "manifest_uploader"

namespace :manifests do
  def manifest_stream(manifest_file)
    case manifest_file
    when IO
      manifest_file
    when String
      File.open(manifest_file)
    when nil
      STDIN
    else
      fail ArgumentError, "Unknown file #{manifest_file.inspect}"
    end
  end

  desc "Creates manifest files on the appropriate GitHub repositories"
  task :upload, [:manifest_file] => :environment do |t, args|
    unless ENV.key?("GITHUB_ACCESS_TOKEN")
      puts "Please set GITHUB_ACCESS_TOKEN environment variable."
      exit 1
    end

    manifests = JSON.load(manifest_stream(args[:manifest_file]))

    client = Octokit::Client.new({
      access_token:  ENV["GITHUB_ACCESS_TOKEN"],
      auto_paginate: true,
      per_page:      100
    })

    repo_names = client.org_repos("codeunion").map(&:name)

    options = { only_fields: %w(category tags notes) }

    manifests.reject { |m| !repo_names.include?(m["name"]) }.each do |manifest|
      puts "Uploading manifest to #{manifest['name']}..."
      ManifestUploader.new(client, manifest, options).run
    end
  end
end
