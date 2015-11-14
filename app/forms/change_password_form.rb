class ChangePasswordForm
  include ActiveModel::Model

  attr_accessor :old_password, :password, :password_confirmation

  validates_presence_of :old_password, :password, :password_confirmation
  validates_confirmation_of :password
  validate :verify_old_password

  def attributes
    {
        :old_password => old_password,
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
    self.old_password = params[:old_password]
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

  def verify_old_password
    self.errors.add(:old_password, I18n.t(:not_valid)) if @user.password != password
  end

end