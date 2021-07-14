class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :rankeable
      t.integer :total_points
      t.integer :total_lost_plays
      t.integer :total_win_plays

      t.timestamps
    end
  end
end
