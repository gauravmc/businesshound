class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.integer :company_id
      t.integer :manager_id

      t.timestamps
    end
  end
end
