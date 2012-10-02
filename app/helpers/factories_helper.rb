module FactoriesHelper
  def supply_quantity(supply)
    if supply.class == Supply and supply.quantity != 0
      supply.quantity
    else
      ''
    end
  end
end