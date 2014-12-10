class Resource < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search_in_readme, against: :readme
end

