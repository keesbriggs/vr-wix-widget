class AddDefaultWidgetWidthAndWidgetHeight < ActiveRecord::Migration
  def up
    change_column_default :widgets, :widget_width, 500
    change_column_default :widgets, :widget_height, 380
  end

  def down
    change_column_default :widgets, :widget_width, nil
    change_column_default :widgets, :widget_height, nil
  end
end
