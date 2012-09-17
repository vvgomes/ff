# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
FF::Application.initialize!

APP_VERSION = `git describe --always`