class User < ActiveRecord::Base
  ADMIN_ROLE = 'admin'
  USER_ROLE  = 'user'

  validates_presence_of :email
  has_secure_password

  def self.roles
    [ADMIN_ROLE, USER_ROLE]
  end

  def ack_entry
    if incl_in_thesis?
      name = full_name
      if not name.empty?
        return name
      elsif not nickname.empty?
        return nickname
      end
    end
    return I18n.t(:anonymous)
  end

  def admin?
    self.role == ADMIN_ROLE
  end

  def full_name
    name = self.first_name.capitalize + ' ' + self.last_name.capitalize
    name.strip
  end

  def ranking_entry
    if incl_in_rankings?
      name = full_name
      if use_full_name? and not name.empty?
        return name
      elsif not nickname.empty?
        return nickname
      end
    end
    return I18n.t(:anonymous)
  end

end
