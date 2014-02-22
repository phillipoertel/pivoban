require 'yaml'
require_relative 'lib/runner'

desc "Fetch current data from Pivotal Tracker"
task :fetch_data do
  config = YAML.load_file('config/settings.yml')
  PROJECT_ID = config['project_id']
  TOKEN      = config['api_token']
  Runner.run
end