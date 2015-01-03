require 'faraday'
require 'reverse_markdown'
require 'nokogiri'

module ResourceLoader

  class CLI
    def initialize(url, category, resource_storage)
      @loader = Loader.new(url, category)
      @resource_storage = resource_storage
    end

    def run
      data = @loader.load
      resource = @resource_storage.find_by(:name => data[:name])

      if resource
        resource.update(data)
      else
        resource = @resource_storage.create(data)
      end

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

  class Loader
    def initialize(url, category)
      @url = url
      @category = category
    end

    def load
      resource = PublicGithubResource.new(@url).to_h
      resource[:category] = @category
      manifest = resource.dup
      resource.delete(:tags)
      manifest.delete(:readme)
      resource[:manifest] = manifest
      resource
    end
  end

  class PublicGithubResource
    def initialize(url)
      response = Faraday.get(url)
      fail(ResourceNotPublic, url) unless response.status == 200
      doc = Nokogiri::HTML(response.body)
      readme = ReverseMarkdown.convert(doc.at_css('#readme > article'), { :unknown_tags => :bypass, :github_flavored => true })
      name = doc.at_css('.js-current-repository').text.strip
      description_node = doc.at_css('.repository-description')

      if description_node
        description = description_node.text.strip
      end
      tag_nodes = doc.at_xpath('//a[@id="user-content-topics-covered"]/../following-sibling::*')

      tags = []
      if tag_nodes
        tags = tag_nodes.css('li').map do |tag_node, b|
          tag_node.text.downcase.gsub(" ", "-")
        end
      end


      resource = {
        :url => url,
        :name => name,
        :description => description,
        :tags => tags,
        :readme => readme,
      }

      @data = resource
    end

    def to_h
      @data
    end
  end

  # Raised when a given resource is not publicly accessible
  class ResourceNotPublic < StandardError; end
end
