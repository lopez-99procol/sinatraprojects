require_relative '../service.rb' # this load the file you are testing
require 'spec_helper.rb' # It will load the configuration you set in spec_helper.rb

describe 'project webservice' do
  context "page" do	
  	it "root is shown" do # the first test
  	  get '/' # you are visiting the home page
  	  expect(last_response.status).to eq(200) # it will true if the home page load successfully
  	end
	
  	it "not_found for unknow route is shown" do
  	  get '/asdfasdf'
  	  expect(last_response.status).to eq(404)
  	  expect(last_response.body).to include("page not found")
  	end
  	
  	it "projects is shown" do
  	  get '/projects'
  	  expect(last_response.status).to eq(200)
  	  expect(last_response.body).to include("procol")
	  end
	  
	  it "show_project to display projects details is shown" do
	    get '/projects/1'
	    expect(last_response.status).to eq(200)
	    expect(last_response.body).to include('big bang')
    end
    
    it "projects is shown after deleting project" do
      delete '/projects/'+ Project.last.id.to_s
      expect(last_response.status).to eq(302)
    end
    
    it "show_project is shown after creating a new project" do
      get '/project/new' 
      expect(last_response.status).to eq(200)
      expect{post '/projects', {
        :title => "lego",
        :description => "the big one on top. take webservice an be a masterbuilder",
        :start => Time.now,
        :finish => Time.local(2099, 12, 31),
        :resource => '1'.to_i}}.to change{Project.count}.by(1)
    end
  end
end