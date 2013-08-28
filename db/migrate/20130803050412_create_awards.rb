class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :title
      t.string :issuer
      t.date :issue_date
      t.text :summary
      t.integer :faculty_member_id

      t.timestamps
    end
  end
end
