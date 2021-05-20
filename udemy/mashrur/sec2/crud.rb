require "bcrypt"

module Crud
  puts "Crud module loaded"

  def get_password_hash(password)
    BCrypt::Password.create(password)
  end

  def verify_password_hash(password)
    BCrypt::Password.new(password)
  end

  def authenticate_user(username, password, user_db)
    user_db.each do |user|
      if user[:username] == username && verify_password_hash(user[:password]) == password
        user
      end
    end
    "Username or password is incorrect"
  end

  def hash_user_db(user_db)
    user_db.each do |user|
      user[:password] = get_password_hash(user[:password])
    end

    user_db
  end
end
