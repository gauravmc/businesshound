class Factory < ActiveRecord::Base
  validates :name, presence: { message: "Factory name is required" }
  validates :name, uniqueness: { scope: :company_id, case_sensitive: false, message: "%{value} already exists" }
  validates_presence_of :stores, message: "Select at least one store for supply"
  
  belongs_to :company
  has_many :products, through: :company
  has_many :supplies, dependent: :destroy
  has_and_belongs_to_many :stores, autosave: true
  
  accepts_nested_attributes_for :supplies
  
  def supplies_to(store)
    stores.include? store
  end
end
