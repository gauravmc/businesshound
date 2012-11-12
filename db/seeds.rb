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

company = Company.create(name: 'Jai Jalaram Food Products', currency: "Rs.")
  
User.create(fullname: 'Gaurav Chande',
            email: 'gmail@gauravchande.com',
            username: 'gauravmc',
            password: '7sjy1bss',
            password_confirmation: '7sjy1bss',
            user_type: 'admin',
            company: company)

Product.create(name: 'Khari 400g',
              price: 50.00,
              company: company)

Product.create(name: 'Toast 200g',
              price: 30.00,
              company: company)
  
Product.create(name: 'Fruit Biscuit',
              price: 30.00,
              company: company)
    
user = User.create(fullname: 'Lala',
                  email: 'lala@gmail.com',
                  username: 'lala',
                  password: 'lala123',
                  password_confirmation: 'lala123',
                  user_type: 'store',
                  company: company)

store = Store.create(name: 'Bengal Chokey Store',
                    company: company,
                    manager: user)
    
user = User.create(fullname: 'Munna',
                  email: 'munna@yahoo.com',
                  username: 'munna',
                  password: 'munna123',
                  password_confirmation: 'munna123',
                  user_type: 'factory',
                  company: company)
                  
Factory.create(name: 'Industrial Estate Factory',
              company: company,
              manager: user,
              stores: [store])

