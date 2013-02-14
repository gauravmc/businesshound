class Factory < ActiveRecord::Base
  validates :name, presence: { message: "Factory name is required" }
  validates :name, uniqueness: { scope: :company_id, case_sensitive: false, message: "%{value} already exists" }
  validates_presence_of :stores, message: "Select at least one store for supply", if: ->(factory) { factory.company.stores.any? }
  
  belongs_to :company
  belongs_to :manager, class_name: 'User', dependent: :destroy
  has_many :products, through: :company, conditions: { kind: 'produced' }
  has_many :supplies, dependent: :destroy
  has_and_belongs_to_many :stores
  alias_method :products_eligible_for_supply_entry, :products
  
  accepts_nested_attributes_for :supplies

  def has_supplied_to_store_on?(supplied_on, store)
    supplies.where(store_id: store.id, supplied_on: supplied_on).any?
  end

  def find_supply_by_attributes(supplied_on, store_id, product_id)
    supply = supplies.where(store_id: store_id, product_id: product_id, supplied_on: supplied_on).pop
    supply.present? ? supply : false
  end

  def fetch_supplies(store_id, supplied_on)
    supplies = []
    products.each do |product|
      supplies << if supply = find_supply_by_attributes(supplied_on, store_id, product.id)
        supply
      else
        self.supplies.create(store_id: store_id, product_id: product.id, quantity: 0, supplied_on: supplied_on)
      end
    end
    supplies
  end
  
  def supplies_to?(store)
    stores.include? store
  end
end
