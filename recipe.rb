class Recipe
  # This class is the factory where instances are creataed or updated
  attr_accessor :name, :description, :prep_time, :status
  def initialize(name, description, prep_time = nil, status = nil)
    @name = name
    @description = description
    @prep_time = prep_time
    @status = status
  end

  def mark!
    @status = !@status
  end
end
