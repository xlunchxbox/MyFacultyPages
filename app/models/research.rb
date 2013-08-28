class Research < ActiveRecord::Base
  validates_presence_of :topic, :summary, :faculty_member_id, :start_date
  belongs_to :faculty_member
end
