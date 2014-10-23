class AddInstanceToSettings < ActiveRecord::Migration
  def change
  	add_column :settings, :instance, :text, :null => true
  end
end
