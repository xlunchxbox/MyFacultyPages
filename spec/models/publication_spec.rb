require 'spec_helper'

describe Publication do
  before(:each) do
    @attr = { :title => 'Sample Publication Title', :summary => 'This is a sample summary.',
      :faculty_member_id => 1, :year => 2000 }
  end

  describe 'instantiation' do
    it 'should require a title' do
      no_title_publication = Publication.new(@attr.merge(:title => ''))
      no_title_publication.should_not be_valid
    end 

    it 'should require a summary' do
      no_summary_publication = Publication.new(@attr.merge(:summary => ''))
      no_summary_publication.should_not be_valid
    end

    it 'should require the ID of the instructor' do
      no_author_publication = Publication.new(@attr.merge(:faculty_member_id => nil))
      no_author_publication.should_not be_valid
    end

    it 'should require the year of publication' do
      no_year_publication = Publication.new(@attr.merge(:year => nil))
      no_year_publication.should_not be_valid
    end

    it 'should create a new instance given valid attributes' do
      Publication.create!(@attr)
    end
  end

  describe 'with faculty member associations' do
    before(:each) do
    	@faculty = FactoryGirl.create(:faculty_member)
      @publication = @faculty.publications.create(@attr)
    end

    it 'should have a faculty member attribute' do 
      @publication.should respond_to(:faculty_member)
    end

    it 'should have the right associated faculty member' do
      @publication.faculty_member_id.should == @faculty.id
      @publication.faculty_member.should == @faculty
    end
  end
end
