class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :business_type
      t.string :currency

      t.timestamps
    end
  end
end
