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
  validates :sign_up_button_text, length: { maximum: 35 }
  before_create :set_default_header_text

  UPDATABLE_KEYS = [:widget_background_color, :widget_height, :widget_width, :header_text, :header_font_type, :header_font_size,
                   :header_font_color, :header_alignment, :subheader_text, :subheader_font_type, :subheader_font_size, 
                   :subheader_font_color, :subheader_alignment, :thank_you_text, :thank_you_font_type, :thank_you_font_size, 
                   :thank_you_font_family, :thank_you_font_color, :thank_you_alignment, :sign_up_button_text, 
                   :sign_up_button_font_type, :sign_up_button_background_color, :sign_up_button_margin_top, 
                   :sign_up_button_margin_bottom, :sign_up_button_rounder_corner_radius, :first_name_required, :first_name_font_type,
                   :first_name_font_style, :first_name_font_size, :first_name_margin_top, :first_name_margin_bottom]

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

  def update_settings(json)
    hash = JSON.parse(json).symbolize_keys!
    # Only update valid attributes, discard the others. Or should we error out?
    hash.slice!(*UPDATABLE_KEYS)
    self.update_attributes(hash)
  end

  private

  def set_default_header_text
    # Problems happen when trying to set a column default value with a string that has single quotes =/
    self.header_text = "Don't Miss Out"
  end
end
