class CreateUserShows < ActiveRecord::Migration[6.1]
  def change
    create_table :user_shows do |t|
      t.references :user, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true

      t.timestamps
    end
  end
end
