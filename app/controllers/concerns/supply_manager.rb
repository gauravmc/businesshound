module SupplyManager
  def supplier
    @supplier
  end

  def supplier_param
    supplier_to_s.to_sym
  end

  def supplier_to_s
  	supplier.class.to_s.parameterize
  end

  def supplier_products
		supplier.products_eligible_for_supply_entry
  end

  def supplier_has_supplied_on?(date)
    if supplier.is_a? Factory
      supplier.has_supplied_to_store_on?(date, @store)
    elsif supplier.is_a? Store
      supplier.has_entered_supplies_on?(date)
    end
  end

  def supplier_bulk_supplies_path
  	eval "#{supplier_to_s}_bulk_supplies_path(supplier, store_id: @store.id)"
  end

  def supplier_success_path
    eval "#{supplier_to_s}_path(supplier)"
  end

  def supplier_fetch_form_path
    if supplier.is_a? Factory
      fetch_form_factory_bulk_supplies_path(supplier, store_id: @store.id)
    elsif supplier.is_a? Store
      fetch_form_store_bulk_supplies_path(supplier, id: @store.id)
    end
  end	
end
