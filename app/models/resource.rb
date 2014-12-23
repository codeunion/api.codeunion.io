class Resource < ActiveRecord::Base
  include PgSearch

  CATEGORIES = %w{ exercises projects examples }

  pg_search_scope :search_in_readme,
                  against: :readme,
                  using: {
                    tsearch: {
                      dictionary: "english",
                      any_word: true,
                      highlight: {
                        start_sel: "<match>",
                        stop_sel: "</match>"
                      }
                    }
                  }

  def self.search(options = {})
    category = options.fetch(:category, nil)
    query    = options.fetch(:query, nil)

    resources = Resource.all

    if category && self.valid_category?(category)
      resources = resources.where("manifest->>'category' = ?", category.to_s)
    end

    if query
      resources = resources.search_in_readme(query)
    end

    return resources
  end

  # This is a hack. Better to use something like ActiveModel::Serializer
  def as_json(options = {})
    json = self.manifest

    # If a highlighted match was found, add it to the JSON
    json["excerpt"] = respond_to?(:pg_highlight) ? pg_highlight : ""

    return json
  end

  def self.valid_category?(category)
    CATEGORIES.include? category.downcase
  end
end
