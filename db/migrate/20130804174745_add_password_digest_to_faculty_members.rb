class AddPasswordDigestToFacultyMembers < ActiveRecord::Migration
  def change
    add_column :faculty_members, :password_digest, :string
  end
end
