class Pair < ApplicationRecord
	has_many :plays_one, class_name: "Play",
												foreign_key: "pair_one_id"

	has_many :plays_two, class_name: "Play",
												foreign_key: "pair_two_id"

	belongs_to :player_one, class_name: "Player"
	belongs_to :player_two, class_name: "Player"

	scope :actives, -> { where(:status => 1) }
  scope :actives_to_day, -> { where(:pair_date => Time.now, :status => 1) }
  # Ex:- scope :active, -> {where(:active => true)}

  def set_points
    self.update(points: self.points.to_i + Player::POINTS, win_plays: self.win_plays.to_i + 1)
    self.player_one.set_points
    self.player_two.set_points
  end

  def substract_points
    self.update(points: self.points.to_i - Player::POINTS, win_plays: self.win_plays.to_i - 1)
    self.player_one.substract_points
    self.player_two.substract_points
  end

  def set_lost_plays
    self.update(lost_plays: self.lost_plays.to_i + 1)
    self.player_one.set_lost_plays
    self.player_two.set_lost_plays
  end

  def substract_lost_plays
    self.update(lost_plays: self.lost_plays.to_i - 1)
    self.player_one.substract_lost_plays
    self.player_two.substract_lost_plays
  end

end
