class CreateJournalEntries < ActiveRecord::Migration
  def change
    create_table :journal_entries do |t|
      t.string :message, limit: 140
      t.decimal :amount, precision: 8, scale: 2
      t.string :kind
      t.integer :store_id
      t.date :occured_on

      t.timestamps
    end
  end
end
