require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  validates :name, uniqueness: true, presence: true

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end

