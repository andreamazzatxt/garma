class CreateFabrics < ActiveRecord::Migration[6.1]
  def change
    create_table :fabrics do |t|
      t.text :description
      t.string :name
      t.integer :rating

      t.timestamps
    end
  end
end
