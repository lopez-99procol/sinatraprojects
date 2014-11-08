require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require_relative 'models/project.rb'

# Abstract HTTP routes
get('/styles.css') {scss :styles}

not_found do
 slim :not_found
end

# Ordinary GET routes
get '/' do
  @title= "Welcome"
  slim :home
  #status 404
end

get '/environment' do
  "#{ENV['SINATRA_ENV']}"
end

get '/projects/new' do
  @title = "Add A New Project"
  @project = Project.new
  slim :new_project
end

get '/projects' do
  @title = "Projects listing"
  @projects = Project.all
  slim :projects
end

get '/projects/:id' do
  id = params[:id]
  @project = Project.get(id)
  @title = @project.title
  slim :show_project
end

get '/projects/:id/edit' do
  @title = "Edit A Project"
  @project = Project.get(params[:id])
  slim :edit_project
end

# DELETE, POST and PUT routes
delete '/projects/:id' do
  id = params[:id]
  Project.get(id).destroy
  redirect to('/projects')
end

post '/projects' do
  project = Project.create(params[:project])
  redirect to("/projects/#{project.id}")
end

put '/projects/:id' do
  project = Project.get(params[:id])
  project.update(params[:project])
  redirect to("/project/#{project.id}")
end



  
