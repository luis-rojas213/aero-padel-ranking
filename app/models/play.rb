class Play < ApplicationRecord
  belongs_to :pair_one, class_name: "Pair"
  belongs_to :pair_two, class_name: "Pair"

  after_save :update_ranking
  #after_update :update_ranking
  before_destroy :delete_ranking

  scope :actives_to_day, -> { where(:status => 1, play_date: Time.now) }
  scope :actives, -> { where(:status => 1) }
  # Ex:- scope :active, -> {where(:active => true)}

  def update_ranking
    if self.pair_one_point > self.pair_two_point
      self.pair_one.set_points
      self.pair_two.set_lost_plays
    elsif self.pair_two_point > self.pair_one_point
      self.pair_two.set_points
      self.pair_one.set_lost_plays
    end
  end

  def delete_ranking
    if self.pair_one_point > self.pair_two_point
      self.pair_one.substract_points
      self.pair_two.substract_lost_plays
    elsif self.pair_two_point > self.pair_one_point
      self.pair_two.substract_points
      self.pair_one.substract_lost_plays
    end
  end
end
