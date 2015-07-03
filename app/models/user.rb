class User < ActiveRecord::Base
  has_secure_password

  def self.roles
    %w[admin, user]
  end

  def admin?
    self.role == 'admin'
  end
end
