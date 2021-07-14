class Player < ApplicationRecord
  has_many :rankings

  has_many :pairs_one, class_name: "Pair",
                        foreign_key: "player_one_id"

  has_many :pairs_two, class_name: "Pair",
  											foreign_key: "player_two_id"
  
  POINTS = 10

  def rankeable?
    self.rankeable.present? && self.rankeable == 1
  end

  def pairs
    Pair.where("player_one_id = #{self.id} OR player_two_id = #{self.id} and status = 1")
  end

  def set_points
    if self.rankeable?
      ranking = Ranking.find_by_player_id_and_status(self.id, 1)
      update_ranking = unless ranking.present?
          Ranking.create(
                          player_id: self.id,
                          points: POINTS,
                          status: 1,
                          win_plays: 1,
                          ranking_date: Time.now
                        )
        else
          ranking.update(
                          points: ranking.points.to_i + POINTS,
                          win_plays: ranking.win_plays.to_i + 1,
                          ranking_date: Time.now
                        )
        end
      if update_ranking
        self.update(
                    total_points: self.total_points.to_i + POINTS,
                    total_win_plays: self.total_win_plays.to_i + 1
                  )
      end
    end
  end

  def substract_points
    if self.rankeable?
      ranking = Ranking.find_by_player_id_and_status(self.id, 1)

      ranking.update(points: ranking.points.to_i - POINTS, win_plays: ranking.win_plays.to_i - 1)
      self.update(
                  total_points: self.total_points.to_i - POINTS,
                  total_win_plays: self.total_win_plays - 1
                )
    end
  end

  def set_lost_plays
    if self.rankeable?
      ranking = Ranking.find_by_player_id_and_status(self.id, 1)
      update_ranking = unless ranking.present?
          Ranking.create(player_id: self.id, lost_plays: 1, status: 1, ranking_date: Time.now)
        else
          ranking.update(lost_plays: ranking.lost_plays.to_i + 1, ranking_date: Time.now)
        end
      if update_ranking
        self.update(total_lost_plays: self.total_lost_plays.to_i + 1)
      end
    end
  end

  def substract_lost_plays
    if self.rankeable?
      ranking = Ranking.find_by_player_id_and_status(self.id, 1)

      ranking.update(lost_plays: ranking.lost_plays.to_i - 1)
      self.update(total_lost_plays: self.total_lost_plays.to_i - 1)
    end
  end
end
