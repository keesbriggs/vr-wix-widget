class List < Struct.new(:name, :is_public, :public_name)

  attr_accessor :name, :is_public, :public_name

  attr_accessible :name, :is_public, :public_name

  validates :name, :is_public, :public_name, presence: true
end