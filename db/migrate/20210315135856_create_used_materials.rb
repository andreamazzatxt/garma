class CreateUsedMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :used_materials do |t|
      t.integer :percentage
      t.references :fabric, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
