class Resource < ActiveRecord::Base
  include PgSearch

  CATEGORIES = %w{ exercises projects examples }

  pg_search_scope :search_in_readme, against: :readme

  # This is a hack. Better to use something like ActiveModel::Serializer
  def as_json(options = {})
    self.manifest
  end

  def self.in_category(category)
    self.where("manifest->>'category' = ?", category.to_s)
  end

  def self.valid_category?(category)
    CATEGORIES.include? category.downcase
  end
end
