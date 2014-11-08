require 'dm-core'
require 'dm-migrations'

env = ENV['SINATRA_ENV']

if env == "test"
  DataMapper.setup(:default, "sqlite://#{File.expand_path("../../db",__FILE__)}/test.sqlite")
elsif env == "development"
  DataMapper.setup(:default, "sqlite://#{File.expand_path("../../db",__FILE__)}/development.sqlite")
elsif env == "production"
  DataMapper.setup(:default, "sqlite://#{File.expand_path("../../db",__FILE__)}/production.sqlite")
else
  raise ArgumentError, 'No SINATRA_ENV specified'
end

class ModelBase

end