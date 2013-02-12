class Supply < ActiveRecord::Base  
  validates :quantity, numericality: { greater_than_or_equal_to: 0, message: "is not a valid number"}
  validates_presence_of :supplied_on, :product, :store
  validates :product_id, uniqueness: { scope: [:store_id, :supplied_on], message: "Entry already made for given date." }  
  
  belongs_to :factory
  belongs_to :product
  belongs_to :store

  before_validation :make_quantity_validation_friendly

  private

  def make_quantity_validation_friendly
    self.quantity = 0 if quantity.nil?
  end
end
