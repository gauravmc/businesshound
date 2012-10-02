class CreateFactories < ActiveRecord::Migration
  def change
    create_table :factories do |t|
      t.string :name
      t.integer :company_id
      t.integer :manager_id

      t.timestamps
    end
  end
end
