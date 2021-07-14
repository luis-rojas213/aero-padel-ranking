class CreateRankings < ActiveRecord::Migration[6.0]
  def change
    create_table :rankings do |t|
      t.integer :player_id
      t.integer :points
      t.integer :lost_plays
      t.integer :win_plays
      t.integer :status
      t.date :ranking_date

      t.timestamps
    end
  end
end
