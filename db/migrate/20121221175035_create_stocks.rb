class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :store_id
      t.integer :product_id
      t.integer :quantity
      t.date :left_on

      t.timestamps
    end
  end
end
