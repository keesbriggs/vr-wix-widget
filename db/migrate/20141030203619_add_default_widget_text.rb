class AddDefaultWidgetText < ActiveRecord::Migration
  def up
    change_column :widgets, :header_text, :string, :default => "Don't miss out", :limit => 100
    change_column :widgets, :subheader_text, :string, :default => "Get instant alerts on our deals", :limit => 100
    change_column :widgets, :sign_up_button_text, :string, :default => "Sign Up", :limit => 35
  end

  def down
    change_column :widgets, :header_text, :string, :default => nil, :limit => nil
    change_column :widgets, :subheader_text, :string, :default => nil, :limit => nil
    change_column :widgets, :sign_up_button_text, :string, :default => nil, :limit => nil
  end
end
