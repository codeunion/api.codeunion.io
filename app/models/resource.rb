class Resource < ActiveRecord::Base
  CATEGORIES = %w( exercise project example )

  has_many :search_results

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }

  include PgSearch
  RANK_BY_UNIQUE_WORDS_IN_DOCUMENT = 8
  RANK_BY_MEAN_HARMONIC_DISTANCE   = 4

  RANKING = RANK_BY_MEAN_HARMONIC_DISTANCE + RANK_BY_UNIQUE_WORDS_IN_DOCUMENT

  pg_search_scope(:search_in_readme,
    against: { name: "A", description: "B", readme: "C" },
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
  )

  def self.in_category(category)
    return self if category.blank?

    where("manifest->>'category' = ?", normalize_category(category))
  end

  def self.search(options = {})
    category = options.fetch(:category, nil)
    query    = options.fetch(:query, nil)

    resources = Resource.all

    if valid_category?(category)
      resources = resources.in_category(category)
    end

    if query
      resources = resources.search_in_readme(query)
    end

    resources.each_with_index do |resource, rank|
      resource.search_results.create(query: query, rank: rank)
    end

    resources
  end

  # This is a hack. Better to use something like ActiveModel::Serializer
  def as_json(_options = {})
    manifest.reverse_merge(
      "excerpt" => respond_to?(:pg_highlight) ? pg_highlight : "",
      "tags"    => []
    )
  end

  def has_search_results_for?(query)
    search_results.where(query: query).present?
  end

  def self.valid_category?(category)
    CATEGORIES.include? normalize_category(category)
  end

  # Idempotently creates or updates the database given a resource manifest.
  #
  # @note *does not* verify the object persisted safely.
  #   Use `valid?` and `errors` for that.
  #
  # @param manifest [Hash] The manifest to persist
  # @return [Resource] the updated or created manifest.
  def self.create_or_update_from_manifest(manifest)
    data = convert_manifest_to_resource_schema(manifest)
    resource = find_by(name: data[:name])

    if resource
      resource.update(data)
    else
      resource = create(data)
    end

    resource
  end

  def self.convert_manifest_to_resource_schema(manifest)
    resource = manifest.dup
    resource.delete(:tags)
    manifest.delete(:readme)
    resource[:manifest] = manifest
    resource
  end

  def self.normalize_category(category)
    category.to_s.downcase.singularize
  end
end
