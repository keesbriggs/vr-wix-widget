class CreateUserTable < ActiveRecord::Migration
  def change
  	create_table :users do |t|
      t.integer :vr_user_id
      t.string  :access_token
 
      t.timestamps
    end
  end
end
