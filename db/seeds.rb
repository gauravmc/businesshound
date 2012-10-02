# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Company.delete_all
User.delete_all
Product.delete_all
Store.delete_all
Factory.delete_all
ActiveRecord::Base.connection.execute("DELETE FROM factories_stores")

company = Company.create(name: 'Jai Jalaram Soap Industry', business_type: "1", currency: "$")
  
User.create(fullname: 'Gaurav Chande',
            email: 'gmail@gauravchande.com',
            username: 'gauravmc',
            password: '7sjy1bss',
            password_confirmation: '7sjy1bss',
            user_type: 'admin',
            company_id: company.id)

Product.create(name: 'Shakti Soap',
              price: 40.50,
              company_id: company.id)

Product.create(name: 'Dawn Soap',
              price: 22.25,
              company_id: company.id)
  
Product.create(name: 'Toofan Soap',
              price: 30,
              company_id: company.id)
    
user = User.create(fullname: 'Some Guy',
                  email: 'gmail@gmail.com',
                  username: 'bengalchokey',
                  password: '7sjy1bss',
                  password_confirmation: '7sjy1bss',
                  user_type: 'store',
                  company_id: company.id)

store = Store.create(name: 'Bengal Chokey Store',
                    company_id: company.id,
                    manager_id: user.id)
    
user = User.create(fullname: 'Some Other Guy',
                  email: 'gmail@yahoo.com',
                  username: 'sakat',
                  password: '7sjy1bss',
                  password_confirmation: '7sjy1bss',
                  user_type: 'factory',
                  company_id: company.id)
                  
Factory.create(name: 'Sakat Factory',
              company_id: company.id,
              manager_id: user.id,
              stores: [store])

