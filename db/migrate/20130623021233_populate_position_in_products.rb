class PopulatePositionInProducts < ActiveRecord::Migration
  def up
    Company.all.each do |company|
      company.products.order(:name).each.with_index do |product, i|
        product.update_attributes(position: i+1)
      end
    end
  end

  def down
  end
end
