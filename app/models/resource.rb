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
                           .highlight_result(query)
    end

    return resources
  end

  # This is a hack. Better to use something like ActiveModel::Serializer
  def as_json(options = {})
    json = self.manifest

    # If a highlighted match was found, add it to the JSON
    json["excerpt"] = respond_to?(:excerpt) ? excerpt : ""

    return json
  end

  def self.valid_category?(category)
    CATEGORIES.include? category.downcase
  end

  def self.highlight_result(query)
    self.select("ts_headline(#{quoted_table_name}.\"readme\", (#{ts_queries(query)}), 'StartSel=<match>, StopSel=</match>, MinWords=20') AS excerpt")
  end

private

  # Warning: improper interpolation techniques used. Not safe. Needs proper fix.
  def self.ts_queries(query)
    query.split(" ").map do |query_term|
      "to_tsquery('english', ''' ' || '#{query_term}' || ' ''')"
    end.join(' || ')
  end
end
