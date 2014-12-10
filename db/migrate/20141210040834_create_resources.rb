class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.json :manifest, null: false
      t.text :readme

      t.timestamps null: false
    end
  end
end
