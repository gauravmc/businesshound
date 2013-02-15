class CreateCashEntries < ActiveRecord::Migration
  def change
    create_table :cash_entries do |t|
      t.text :denomination
      t.integer :store_id
      t.date :made_on

      t.timestamps
    end
  end
end
