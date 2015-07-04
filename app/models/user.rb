class User < ActiveRecord::Base
  has_secure_password

  def self.roles
    %w[admin, user]
  end

  def ack_entry
    return 'Anonymous' unless self.incl_in_thesis?

    name = full_name
    if not name.empty?
      name
    else
      self.nickname
    end
  end

  def admin?
    self.role == 'admin'
  end

  def full_name
    name = self.first_name.capitalize + ' ' + self.last_name.capitalize
    name.strip
  end

  def ranking_entry
    return 'Anonymous' unless self.incl_in_rankings?

    name = full_name
    if self.use_full_name? and not name.empty?
      name
    else
      self.nickname
    end
  end

end
