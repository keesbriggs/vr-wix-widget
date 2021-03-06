class Widget < ActiveRecord::Base
  
  attr_accessible   :user_id,  :instance_id, :comp_id,  :widget_background_color,  :widget_height,	:widget_width,  
  					:header_text, :header_font_type,  :header_font_size,  :header_font_color,  :header_alignment,  
  					:subheader_text, :subheader_font_type, :subheader_font_size, :subheader_font_color,  :subheader_alignment,	
  					:thank_you_text, :thank_you_font_type, :thank_you_font_size, :thank_you_font_family,  
  					:thank_you_font_color, :thank_you_alignment, :sign_up_button_text, :sign_up_button_font_type,  
  					:sign_up_button_background_color, :sign_up_button_width, :sign_up_button_font_color,  
  					:sign_up_button_font_size, :sign_up_button_margin_top,  :sign_up_button_margin_bottom,  
  					:sign_up_button_rounder_corner_radius, :first_name_required, :first_name_font_type,  
  					:first_name_font_style, :first_name_font_size, :first_name_margin_top, :first_name_margin_bottom

  validates :instance_id, :comp_id, presence: true
  validates :header_text, :subheader_text, length: { maximum: 100 }
  validates :sign_up_button_text, length: { maximum: 100 }

  RETURN_VALUES = [:widget_background_color, :widget_height, :widget_width, :header_text, :header_font_type, :header_font_size,
                   :header_font_color, :header_alignment, :subheader_text, :subheader_font_type, :subheader_font_size, 
                   :subheader_font_color, :subheader_alignment, :thank_you_text, :thank_you_font_type, :thank_you_font_size, 
                   :thank_you_font_family, :thank_you_font_color, :thank_you_alignment, :sign_up_button_text, 
                   :sign_up_button_font_type, :sign_up_button_background_color, :sign_up_button_margin_top, 
                   :sign_up_button_margin_bottom, :sign_up_button_rounder_corner_radius, :first_name_required, :first_name_font_type,
                   :first_name_font_style, :first_name_font_size, :first_name_margin_top, :first_name_margin_bottom]

  def as_json(options)
    # Return only the values that can be customized by the user
    # TODO: When using VR2 API, might need to include the Contact List ID the users wants to add contacts to
    # (add db field in Widget table, and prop in Widget class)
    super(:only => RETURN_VALUES)
  end

  # TODO: build a parsing method that allows users to actually change the values of the props according to the settings chosen in Wix editor
end
