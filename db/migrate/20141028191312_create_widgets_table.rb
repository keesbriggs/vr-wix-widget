class CreateWidgetsTable < ActiveRecord::Migration
  def change
  	create_table :widgets do |t|
      t.integer :user_id
      t.string  :instance_id, null: false
      t.string	:comp_id, null: false

      t.string  :widget_background_color
      t.string  :widget_height
      t.string	:widget_width

      t.string  :header_text
	  t.string	:header_font_type
	  t.string  :header_font_size
	  t.string  :header_font_color
	  t.string  :header_alignment

	  t.string  :subheader_text
	  t.string  :subheader_font_type
	  t.string  :subheader_font_size
	  t.string  :subheader_font_color
	  t.string  :subheader_alignment

	  t.string	:thank_you_text
	  t.string  :thank_you_font_type
	  t.string  :thank_you_font_size
	  t.string  :thank_you_font_family
	  t.string  :thank_you_font_color
	  t.string  :thank_you_alignment

	  t.string  :sign_up_button_text
	  t.string  :sign_up_button_font_type
	  t.string  :sign_up_button_background_color
	  t.string	:sign_up_button_width
	  t.string	:sign_up_button_font_color
	  t.string  :sign_up_button_font_size
	  t.string  :sign_up_button_margin_top
	  t.string  :sign_up_button_margin_bottom
	  t.string  :sign_up_button_rounder_corner_radius

	  t.string  :first_name_required
	  t.string  :first_name_font_type
	  t.string  :first_name_font_style
	  t.string  :first_name_font_size
	  t.string  :first_name_margin_top
	  t.string  :first_name_margin_bottom
 
      t.timestamps
    end
  end
end
