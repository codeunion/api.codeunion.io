class Resource < ActiveRecord::Base
  include PgSearch

  CATEGORIES = %w{ exercises projects examples }

  pg_search_scope :search_in_readme, against: :readme

  def self.in_category(category)
    self.where("manifest->>'category' = ?", category.to_s)
  end

  def self.valid_category?(category)
    CATEGORIES.include? category.downcase
  end
end
