class AddRememberTokenToFacultyMembers < ActiveRecord::Migration
  def change
    add_column :faculty_members, :remember_token, :string
    add_index :faculty_members, :remember_token
  end
end
