class GuestUser
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def admin?
    false
  end

  def privilege_labels
    ["No specific rights"]
  end
end
