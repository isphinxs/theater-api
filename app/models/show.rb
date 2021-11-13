class Show < ApplicationRecord
    has_many :user_shows
    has_many :users, through: :user_shows
    has_many :comments
    has_many :ratings

    def self.create_from_collection(shows)
        shows.each do |show|
            Show.create(show)
        end
    end
end
