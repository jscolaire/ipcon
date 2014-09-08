#encoding : utf-8
class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :password, :password_confirmation

  attr_accessor :password
  before_save :prepare_password

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "Should only contain letters, numbers, or .-_@"
  validates_presence_of :password, :on => :create, :message => "Password can't be blank"
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 8, :allow_blank => false

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  private

  def prepare_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = encrypt_password(password)
  end

end
