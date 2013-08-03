require 'mongoid'
require 'bcrypt'

class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :password_hash, type: String
  field :password_salt, type: String

  validates_presence_of :name
  validates_presence_of :email

  def self.find_by_email(email)
    self.where(email: email).first
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user and user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def self.create_user(name, email, password, initial_create = false)
    user = find_by_email(email) unless initial_create
    if initial_create or user.nil?
      user = User.new(name: name, email: email)
      user.update_password(password)
      user.save!
      user
    else
      throw 'User with this email already exists !'
    end
  end

  def update_password(password)
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    set(:password_hash, password_hash)
    set(:password_salt, password_salt)
  end

  def update_with(values)
    update_attributes!(name: values['name'], email: values['email'])
    if values['password']
      update_password(values['password'])
    end
    save!
  end
end
