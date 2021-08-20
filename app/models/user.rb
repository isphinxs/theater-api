class User < ApplicationRecord
    has_secure_password
    has_many :user_shows
    has_many :shows, through: :user_shows
end
