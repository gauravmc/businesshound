class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.integer :factory_id
      t.integer :store_id
      t.integer :product_id
      t.integer :quantity
      t.date :supplied_on

      t.timestamps
    end
  end
end
