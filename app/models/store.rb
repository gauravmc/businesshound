class Store < ActiveRecord::Base
  validates :name, presence: { message: "Store name is required" }
  validates :name, uniqueness: { scope: :company_id, case_sensitive: false, message: "%{value} already exists" }
  validates_presence_of :factories, message: "Select at least one factory that supplies to this store", if: ->(store) { store.company.factories.any? }
  
  belongs_to :company
  belongs_to :manager, class_name: 'User', dependent: :destroy
  has_many :products, through: :company
  has_many :supplies, dependent: :destroy
  has_and_belongs_to_many :factories

  def gets_supplies_by?(factory)
  	factories.include? factory
  end
end
