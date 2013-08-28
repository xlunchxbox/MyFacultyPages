class Employment < ActiveRecord::Base
	validates_presence_of :company, :position, :start_date, :summary, :faculty_member_id
	belongs_to :faculty_member
end
