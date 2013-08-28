class AddFacultyMemberIdToResearches < ActiveRecord::Migration
  def change
    add_column :researches, :faculty_member_id, :integer
  end
end
