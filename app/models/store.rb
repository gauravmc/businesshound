class Store < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { scope: :company_id, case_sensitive: false, message: "%{value} already exists" }
  
  belongs_to :company
  has_many :products, through: :company
  has_and_belongs_to_many :factories
  has_many :supplies
  
  accepts_nested_attributes_for :supplies
end
