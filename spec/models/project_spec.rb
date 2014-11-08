require 'spec_helper.rb'
require_relative '../../models/project.rb'

# Tests for the project model
describe Project do
  context "will be" do
    it "created" do
      expect{Project.create(
              title: "procol", 
              start: Time.now, 
              finish: Time.local(2015,7,8), 
              description: "the big bang project", 
              resource: "1".to_i)}.to change{Project.count}.by(1)
    end
    
    it "destroyed" do
      expect{Project.get(Project.last.id).destroy}.to change{Project.count}.by(-1)
    end
    
  end
  
  
end