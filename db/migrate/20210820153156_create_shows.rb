class CreateShows < ActiveRecord::Migration[6.1]
  def change
    create_table :shows do |t|
      t.string :title
      t.string :theater
      t.string :director
      t.string :music
      t.string :lyrics
      t.string :book
      t.date :open_date
      t.string :type

      t.timestamps
    end
  end
end
