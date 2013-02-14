class Product < ActiveRecord::Base
	default_scope order('name ASC')
	scope :produced, where(kind: 'produced')
	scope :traded, where(kind: 'traded')

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than: 0, message: "should be more than 0"}
  validates :name, uniqueness: { scope: :company_id, case_sensitive: false, message: "%{value} already exists" }
  validates :kind, inclusion: { in: %w{produced traded}, message: "%{value} is not a valid kind"}

  belongs_to :company
  has_many :supplies, dependent: :destroy
  has_many :stocks, dependent: :destroy
end
