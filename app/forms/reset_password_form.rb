class ResetPasswordForm
  include ActiveModel::Model

  attr_accessor :password, :password_confirmation

  validates_presence_of :password, :password_confirmation
  validates_confirmation_of :password

  def attributes
    {
        :password => password,
        :password_confirmation => password_confirmation
    }
  end

  def initialize(user)
    @user = user
  end

  def initialize(user)
    @user = user
  end

  def submit(params)
    self.password = params[:password]
    self.password_confirmation = params[:password_confirmation]

    if valid?
      @user.password = password
      @user.password_confirmation = password_confirmation
      @user.save!
      true
    else
      false
    end
  end

  def persisted?
    false
  end

end