class RemoveBusinessTypeFromCompanies < ActiveRecord::Migration
  def up
  	remove_column :companies, :business_type
  end

  def down
  end
end
