

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 8, allow_nil: true}

  attr_reader :password

  after_initialize :ensure_session_token

  def password=(password)
    @password = password
    pw_dig = BCrypt::Password.create(password)
    self.password_digest = pw_dig
    # self.save
  end

  def is_password?(password)
    pw_dig = BCrypt::Password.new(self.password_digest)
    pw_dig.is_password?(password)
  end

  def generate_session_token
    SecureRandom::urlsafe_base64(32)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def self.find_by_credentials(username, password)
    potential_user = User.find_by(username: username)
    return nil unless potential_user
    potential_user.is_password?(password) ? potential_user : nil
  end


end
