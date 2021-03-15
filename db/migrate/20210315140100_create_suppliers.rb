class CreateSuppliers < ActiveRecord::Migration[6.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.text :address
      t.string :country

      t.timestamps
    end
  end
end
