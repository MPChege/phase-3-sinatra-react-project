class Category < ActiveRecord::Base
    has_many :houses
    has_many :locations, through: :houses
    has_many :sellers, through: :houses
end