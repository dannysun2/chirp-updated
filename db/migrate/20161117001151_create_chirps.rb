class CreateChirps < ActiveRecord::Migration
  def change
    create_table :chirps do |t|

      t.timestamps null: false
    end
  end
end
