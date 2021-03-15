class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.references :brand, null: false, foreign_key: true
      t.text :photo_url
      t.string :category
      t.string :article_number
      t.string :department

      t.timestamps
    end
  end
end
