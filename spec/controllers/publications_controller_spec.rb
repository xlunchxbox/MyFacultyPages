require 'spec_helper'

describe PublicationsController do
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
	  		response.should have_selector('title', :content => 'Add publication')
	  	end
    end

  	describe "GET request for 'edit'" do
	  	before(:each) do
	  		@publication = FactoryGirl.create(:publication, :faculty_member => @faculty)
	  	end

	  	it 'should be successful' do
	  		get :edit, :id => @publication
	  		response.should be_success
	  	end

	  	it 'should have the correct title' do
  			get :edit, :id => @publication
	  		response.should have_selector('title', :content => 'Edit publication')
  		end
  	end

	  describe "POST request for 'create'" do
		  describe 'failure' do
			  before(:each) do
				  @attr = { :title => '', :summary => '', :year => nil }
			  end

			  it 'should not create an invalid publication' do
				  lambda do
					  post :create, :publication => @attr
				  end.should_not change(Publication, :count)
		  	end

			  it 'should have the correct title' do
				  post :create, :publication => @attr
				  response.should have_selector('title', :content => 'Add publication')
			  end

			  it "should render the 'new' page" do
				  post :create, :publication => @attr
				  response.should render_template('new')
			  end
		  end

		  describe 'success' do
			  before(:each) do
				  @attr = { :title => 'Sample Foo Title', :summary => 'Sample summary foo', :year => 1996,
            :faculty_member_id => @faculty.id }
			  end

			  it 'should create a publication' do
				  lambda do
					  post :create, :publication => @attr
				  end.should change(Publication, :count).by(1)
			  end

			  it "should redirect to the faculty member's publications page" do
				  post :create, :publication => @attr
				  response.should redirect_to(publications_faculty_member_path(@faculty))
			  end
		  end
	  end

	  describe "PATCH request for 'update'" do
		  before(:each) do
			  @publication = FactoryGirl.create(:publication, :faculty_member => @faculty)
		  end

		  describe 'failure' do
			  before(:each) do
				  @attr = { :title => '', :summary => '', :year => nil }
			  end

			  it "should render the 'edit' page" do
				  patch :update, :id => @publication, :publication => @attr
				  response.should render_template('edit')
			  end

			  it 'should have the right title' do
				  patch :update, :id => @publication, :publication => @attr
				  response.should have_selector('title', :content => 'Edit publication')
			  end
		  end

		  describe 'success' do
			  before(:each) do
				  @attr = { :title => 'New Foo Title', :summary => 'New foo summary' }
			  end

			  it "should change the publication's attributes" do
				  patch :update, :id => @publication, :publication => @attr
				  @publication.reload
				  @publication.title.should == @attr[:title]
				  @publication.summary.should == @attr[:summary]
			  end

			  it "should redirect to the faculty member's publications page" do
				  patch :update, :id => @publication, :publication => @attr
				  response.should redirect_to(publications_faculty_member_path(@faculty))
			  end
		  end
	  end

	  describe "DELETE request for 'destroy'" do
		  before(:each) do
			  @publication = FactoryGirl.create(:publication, :faculty_member => @faculty)
		  end

		  it 'should delete the publication' do
			  lambda do
			  	delete :destroy, :id => @publication
			  end.should change(Publication, :count).by(-1)
		  end

		  it "should redirect to the faculty member's publications page" do
			  delete :destroy, :id => @publication
			  response.should redirect_to(publications_faculty_member_path(@faculty))
		  end
	  end
  end

  describe 'for users not signed in' do
  	before(:each) do
  		@publication = FactoryGirl.create(:publication, :faculty_member => @faculty)
  	end

  	it "should deny access to GET 'new'" do
  		get :new
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to GET 'edit'" do
  		get :edit, :id => @publication
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to POST 'create'" do
  		@attr = { :title => 'Sample Foo Title', :summary => 'Sample summary foo', :year => 1996,
        :faculty_member_id => @faculty.id }
  		post :create, :publication => @attr
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to PATCH 'update'" do
  		patch :update, :id => @publication, :publication => {}
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to DELETE 'destroy'" do
  		delete :destroy, :id => @publication
  		response.should redirect_to(signin_path)
  	end
  end
end

