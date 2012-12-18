module Factory::SuppliesHelper
  def supplied_to(store)
    if store.supplies.where(supplied_on: Date.today).any?
      true
    else
      false
    end
  end
  
  def get_factory_supply_path(store)
    if supplied_to(store)
      edit_factory_supply_path(store)
    else
      new_factory_supply_path(store_id: store.id)
    end
  end
end
