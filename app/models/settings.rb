class Settings < ActiveRecord::Base
  #self.primary_key = 'key' # causes postgres error on heroku
  self.primary_key = 'id'
  
  attr_accessible :key, :value
end
