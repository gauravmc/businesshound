class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, :precision => 10, :scale => 2
      t.integer :company_id

      t.timestamps
    end
  end
end
