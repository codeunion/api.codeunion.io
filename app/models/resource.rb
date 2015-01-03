class Resource < ActiveRecord::Base
  has_many :search_results

  include PgSearch

  CATEGORIES = %w{ exercises projects examples }
  RANK_BY_UNIQUE_WORDS_IN_DOCUMENT = 8
  RANK_BY_MEAN_HARMONIC_DISTANCE   = 4

  RANKING = RANK_BY_MEAN_HARMONIC_DISTANCE + RANK_BY_UNIQUE_WORDS_IN_DOCUMENT

  pg_search_scope :search_in_readme,
                  against:  { name: 'A', description: 'B', readme: 'C' },
                  using: {
                    tsearch: {
                      dictionary: "english",
                      normalization: RANKING,
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

    resources.each_with_index do |resource, rank|
      resource.search_results.create({
        query: query,
        rank: rank
      })
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

  def has_search_results_for?(query)
    search_results.where({ :query => query }).present?
  end

  def self.valid_category?(category)
    CATEGORIES.include? category.downcase
  end
end
