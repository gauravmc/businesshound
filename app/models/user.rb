class User < ActiveRecord::Base
  has_secure_password

  validates :fullname, presence: true, if: :creating_company?
  validates :email,
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: true,
            if: :creating_company?
  validates :password, length: { minimum: 6 }
  validates :username,
            format: { with: /^[a-zA-Z0-9_]*[a-zA-Z][a-zA-Z0-9_]*$/ },
            uniqueness: { message: "%{value} already exists" }
  validates :user_type, inclusion: { in: %w(admin store factory), message: "%{value} is not a valid type of user" }
  
  belongs_to :company
  has_one :factory, foreign_key: :manager_id
  has_one :store, foreign_key: :manager_id
  
  before_save :create_remember_token
  
  def type
    user_type
  end
  
  private
    def creating_company?
      Company.creating_new == true
    end
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
