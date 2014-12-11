class Resource < ActiveRecord::Base
  include PgSearch

  CATEGORIES = %w{ exercises projects examples }

  pg_search_scope :search_in_readme,
                  against: :readme,
                  using: {
                    tsearch: {
                      dictionary: "english",
                      any_word: true
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
    self.manifest
  end

  def self.valid_category?(category)
    CATEGORIES.include? category.downcase
  end
end
