require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require_relative 'models/project.rb'

get('/styles.css') {scss :styles}

not_found do
 slim :not_found
end

get '/' do
  @title= "Welcome"
  slim :home
  #status 404
end

get '/projects/new' do
  @title = "Add A New Project"
  @project = Project.new
  slim :project_new
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

delete '/projects/:id' do
  id = params[:id]
  Project.get(id).destroy
  redirect to('/projects')
end

post '/projects' do
  project = Project.create(params[:project])
  redirect to("/projects/#{project.id}")
end
