require 'spec_helper'

describe Research do
  before(:each) do
    @attr = { :topic => 'Sample Research Topic', :start_date => Date.new(1997, 1, 1), :end_date => Date.today,
      :summary => 'Sample research topic goes here.', :faculty_member_id => 1 }
  end

  describe 'instantiation' do
    it 'should require a topic' do
      no_topic_research = Research.new(@attr.merge(:topic => ''))
      no_topic_research.should_not be_valid
    end

    it 'should require a summary' do
      no_summary_research = Research.new(@attr.merge(:summary => ''))
      no_summary_research.should_not be_valid
    end

    it 'should require a faculty ID reference' do
      no_faculty_reference = Research.new(@attr.merge(:faculty_member_id => nil))
      no_faculty_reference.should_not be_valid
    end

    it 'should require a starting date' do
      no_start_date_research = Research.new(@attr.merge(:start_date => nil))
      no_start_date_research.should_not be_valid
    end

    it 'should create an instance given valid attributes' do
      Research.create!(@attr)
    end
  end

  describe 'associations' do
  	before(:each) do
  		@faculty = FactoryGirl.create(:faculty_member)
  		@research = @faculty.researches.create(@attr)
  	end

  	describe 'with faculty member' do
  		it 'should have a faculty member attribute' do
        @research.should respond_to(:faculty_member)
      end

      it 'should have the right associated faculty member' do
        @research.faculty_member_id.should == @faculty.id
        @research.faculty_member.should == @faculty
      end
  	end
  end
end
