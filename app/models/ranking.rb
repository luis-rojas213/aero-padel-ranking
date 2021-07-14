class Ranking < ApplicationRecord
	belongs_to :player

  scope :actives, -> { where(:status => 1) }
end
