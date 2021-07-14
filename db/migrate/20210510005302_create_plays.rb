class CreatePlays < ActiveRecord::Migration[6.0]
  def change
    create_table :plays do |t|
      t.integer :pair_one_id
      t.integer :pair_two_id
      t.integer :pair_one_point
      t.integer :pair_two_point
      t.date :play_date
      t.integer :status

      t.timestamps
    end
  end
end
