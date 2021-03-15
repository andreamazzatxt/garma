class CreateBrands < ActiveRecord::Migration[6.1]
  def change
    create_table :brands do |t|
      t.string :name
      t.integer :rating
      t.integer :planet_rating
      t.integer :people_rating
      t.integer :animals_rating
      t.text :planet_description
      t.text :people_description
      t.text :animals_description

      t.timestamps
    end
  end
end
