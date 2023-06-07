class Location < ActiveRecord::Base
    has_many :houses
    has_many :categories, through: :houses
    has_many :sellers, through: :houses
end