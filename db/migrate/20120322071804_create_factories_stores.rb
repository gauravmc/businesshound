class CreateFactoriesStores < ActiveRecord::Migration
  def change
    create_table :factories_stores do |t|
      t.integer :factory_id
      t.integer :store_id
    end
  end
end
