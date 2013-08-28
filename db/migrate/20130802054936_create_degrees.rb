class CreateDegrees < ActiveRecord::Migration
  def change
    create_table :degrees do |t|
      t.string :title
      t.string :field_of_study
      t.string :institution
      t.date :issue_date
      t.integer :faculty_member_id

      t.timestamps
    end
  end
end
