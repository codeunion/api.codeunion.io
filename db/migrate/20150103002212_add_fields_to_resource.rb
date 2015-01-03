class AddFieldsToResource < ActiveRecord::Migration
  def change
    add_column :resources, :name, :string
    add_column :resources, :description, :text
    add_column :resources, :url, :string
    add_column :resources, :category, :string
  end
end
