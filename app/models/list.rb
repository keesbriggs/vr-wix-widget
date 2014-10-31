class List < Struct.new(
  :name, :is_public, :public_name)

  def initialize(attributes = {})
    super(*attributes.values_at(*self.class.members))
  end
end