class User < ActiveRecord::Base

  has_many :widgets, inverse_of: :user
  
  attr_accessible :vr_user_id, :access_token
end
