class House < ActiveRecord::Base
    belongs_to :category
    belongs_to :location
    belongs_to :seller
end
