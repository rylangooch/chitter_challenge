require 'bcrypt'
require 'data_mapper'
require 'dm-postgres-adapter'

class User
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  validates_format_of :email, as: :email_address

  property :id,       Serial
  property :email,    String, required: true, unique: true
  property :name,     String
  property :username, String, required: true, unique: true
  property :password_digest, String, length: 60

  has n, :peeps, through: Resource

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
     user if user && BCrypt::Password.new(user.password_digest) == password
  end
end
