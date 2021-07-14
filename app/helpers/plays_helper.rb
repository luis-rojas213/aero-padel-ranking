module PlaysHelper
  def pair_select_options(pairs)
    pairs.map { |p| ["#{p.player_one.first_name} - #{p.player_two.first_name}", p.id] }
  end
end
