class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
		t.column :key,
    		:string, :null => true
    	t.column :value,
    		:text, :null => true
    	t.timestamps		
    end
  end
end
