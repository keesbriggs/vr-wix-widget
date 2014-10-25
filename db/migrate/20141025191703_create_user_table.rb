class CreateUserTable < ActiveRecord::Migration
  def change
  	create_table :user_access_token do |t|
      t.integer :vr_user_id, 	   null: false
      t.string  :access_token, null: false
 
      t.timestamps
    end
  end
end
