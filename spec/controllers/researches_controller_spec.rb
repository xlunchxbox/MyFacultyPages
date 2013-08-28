require 'spec_helper'

describe ResearchesController do
	render_views

	before(:each) do
		@faculty = FactoryGirl.create(:faculty_member)
	end

	describe 'for faculty members signed in' do
  	before(:each) do
  		controller.sign_in(@faculty)
  	end

  	describe "GET request for 'new'" do
  		it 'should be successful' do
	  		get :new
	  		response.should be_success
  		end

  		it 'should have the correct title' do
	  		get :new
	  		response.should have_selector('title', :content => 'Add research')
	  	end
    end

  	describe "GET request for 'edit'" do
	  	before(:each) do
	  		@research = FactoryGirl.create(:research, :faculty_member => @faculty)
	  	end

	  	it 'should be successful' do
	  		get :edit, :id => @research
	  		response.should be_success
	  	end

	  	it 'should have the correct title' do
  			get :edit, :id => @research
	  		response.should have_selector('title', :content => 'Edit research')
  		end
  	end

	  describe "POST request for 'create'" do
		  describe 'failure' do
			  before(:each) do
				  @attr = { :dept_code => '', :research_no => nil, :research_name => '', :term => '',
				    :year => nil, :summary => '' }
			  end

			  it 'should not create an invalid research' do
				  lambda do
					  post :create, :research => @attr
				  end.should_not change(Research, :count)
		  	end

			  it 'should have the correct title' do
				  post :create, :research => @attr
				  response.should have_selector('title', :content => 'Add research')
			  end

			  it "should render the 'new' page" do
				  post :create, :research => @attr
				  response.should render_template('new')
			  end
		  end

		  describe 'success' do
			  before(:each) do
				  @attr = { :topic => 'Foo topic', :start_date => Date.new(1996, 1, 1), :end_date => Date.today,
            :summary => 'Foo summary', :faculty_member_id => @faculty.id }
			  end

			  it 'should create a research' do
				  lambda do
					  post :create, :research => @attr
				  end.should change(Research, :count).by(1)
			  end

			  it "should redirect to the faculty member's researches page" do
				  post :create, :research => @attr
				  response.should redirect_to(researches_faculty_member_path(@faculty))
			  end
		  end
	  end

	  describe "PATCH request for 'update'" do
		  before(:each) do
			  @research = FactoryGirl.create(:research, :faculty_member => @faculty)
		  end

		  describe 'failure' do
			  before(:each) do
				  @attr = { :topic => '', :start_date => nil, :end_date => nil, :summary => nil }
			  end

			  it "should render the 'edit' page" do
				  patch :update, :id => @research, :research => @attr
				  response.should render_template('edit')
			  end

			  it 'should have the right title' do
				  patch :update, :id => @research, :research => @attr
				  response.should have_selector('title', :content => 'Edit research')
			  end
		  end

		  describe 'success' do
			  before(:each) do
				  @attr = { :topic => 'New foo topic', :summary => 'New foo summary'}
			  end

			  it "should change the research's attributes" do
				  patch :update, :id => @research, :research => @attr
				  @research.reload
				  @research.topic == @attr[:topic]
				  @research.summary.should == @attr[:summary]
			  end

			  it "should redirect to the faculty member's researches page" do
				  patch :update, :id => @research, :research => @attr
				  response.should redirect_to(researches_faculty_member_path(@faculty))
			  end
		  end
	  end

	  describe "DELETE request for 'destroy'" do
		  before(:each) do
			  @research = FactoryGirl.create(:research, :faculty_member => @faculty)
		  end

		  it 'should delete the research' do
			  lambda do
			  	delete :destroy, :id => @research
			  end.should change(Research, :count).by(-1)
		  end

		  it "should redirect to the faculty member's researches page" do
			  delete :destroy, :id => @research
			  response.should redirect_to(researches_faculty_member_path(@faculty))
		  end
	  end
  end

  describe 'for users not signed in' do
  	before(:each) do
  		@research = FactoryGirl.create(:research, :faculty_member => @faculty)
  	end

  	it "should deny access to GET 'new'" do
  		get :new
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to GET 'edit'" do
  		get :edit, :id => @research
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to POST 'create'" do
  		@attr = { :topic => 'FooTopic', :start_date => Date.new(2001, 1, 1), :end_date => Date.today, 
        :summary => 'Foo Summary', :faculty_member_id => @faculty.id }
  		post :create, :research => @attr
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to PATCH 'update'" do
  		@attr = { :topic => 'New Foo Topic', :summary => 'New foo summary' }
  		patch :update, :id => @research, :research => @attr
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to DELETE 'destroy'" do
  		delete :destroy, :id => @research
  		response.should redirect_to(signin_path)
  	end
  end
end
