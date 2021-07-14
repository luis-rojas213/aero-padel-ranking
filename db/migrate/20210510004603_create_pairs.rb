class CreatePairs < ActiveRecord::Migration[6.0]
  def change
    create_table :pairs do |t|
      t.integer :player_one_id
      t.integer :player_two_id
      t.integer :points
      t.integer :lost_plays
      t.integer :win_plays
      t.date :pair_date
      t.integer :status

      t.timestamps
    end
  end
end
