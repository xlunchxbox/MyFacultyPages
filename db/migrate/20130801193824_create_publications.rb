class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.text :summary
      t.integer :faculty_member_id

      t.timestamps
    end
  end
end
