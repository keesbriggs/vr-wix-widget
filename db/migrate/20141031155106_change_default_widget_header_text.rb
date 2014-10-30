class ChangeDefaultWidgetHeaderText < ActiveRecord::Migration
  def up
    # Moving this default value to a before_create callback in the model
    # Trying to set a default value with single quotes fails horribly =/
    change_column_default :widgets, :header_text, ""
  end

  def down
    change_column_default :widgets, :header_text, "Don't miss out"
  end
end
