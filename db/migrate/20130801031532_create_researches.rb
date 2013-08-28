class CreateResearches < ActiveRecord::Migration
  def change
    create_table :researches do |t|
      t.string :topic
      t.date :start_date
      t.date :end_date
      t.text :summary

      t.timestamps
    end
  end
end
