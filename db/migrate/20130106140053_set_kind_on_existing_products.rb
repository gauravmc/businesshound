class SetKindOnExistingProducts < ActiveRecord::Migration
  def up
  	Product.all.each do |product|
  		product.kind = 'produced'
  		product.save!
  	end
  end

  def down
  end
end
