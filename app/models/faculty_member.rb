class FacultyMember < ActiveRecord::Base
  before_create :create_remember_token

  validates_presence_of :last_name, :first_name, :position, :department, :university_id, :email
  validates_length_of :phone, :is => 10
  validates_uniqueness_of :university_id, :phone, :email

  has_many :courses, :dependent => :destroy
  has_many :researches, :dependent => :destroy
  has_many :publications, :dependent => :destroy
  has_many :degrees, :dependent => :destroy
  has_many :employments, :dependent => :destroy
  has_many :awards, :dependent => :destroy
  
  has_secure_password

  def FacultyMember.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def FacultyMember.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  
    def create_remember_token
      self.remember_token = FacultyMember.encrypt(FacultyMember.new_remember_token)
    end
end
