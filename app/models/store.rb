class Store < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { scope: :company_id, case_sensitive: false, message: "%{value} already exists" }
  
  belongs_to :company
  belongs_to :manager, class_name: 'User'
  has_many :products, through: :company
  has_and_belongs_to_many :factories, autosave: true
  has_many :supplies
end
