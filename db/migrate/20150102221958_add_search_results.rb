class AddSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|
      t.string :query
      t.integer :rank
      t.references :resource
    end
  end
end
