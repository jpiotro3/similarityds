class Session
  include ActiveModel::Model

  attr_accessor :email, :password

  validates_presence_of :email
  validates_presence_of :password

  def attributes
    { :email => email, :password => password }
  end

  def persisted?
    false
  end

end