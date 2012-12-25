module Factory::SuppliesHelper
  def get_factory_supply_path(factory, store, date)
    if factory.has_supplied_to_store_on? date, store.id
      edit_factory_supply_path(store)
    else
      new_factory_supply_path(store_id: store.id)
    end
  end
end
