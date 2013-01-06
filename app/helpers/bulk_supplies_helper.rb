module BulkSuppliesHelper
  def get_factory_bulk_supply_path(factory, store, date)
    if factory.has_supplied_to_store_on? date, store
      edit_factory_bulk_supplies_path(factory, store_id: store.id)
    else
      new_factory_bulk_supply_path(factory, store_id: store.id)
    end
  end
end
