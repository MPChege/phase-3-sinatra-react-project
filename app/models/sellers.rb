class Seller < ActiveRecord::Base
    has_many :houses
    has_many :locations, through: :houses
    has_many :categories, through: :houses
end