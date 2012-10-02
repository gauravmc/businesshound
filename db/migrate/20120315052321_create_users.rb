class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :email
      t.string :username
      t.string :password_digest
      t.string :user_type
      t.integer :company_id

      t.timestamps
    end
  end
end
