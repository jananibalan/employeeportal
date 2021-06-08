require_relative 'App'
require 'rack/cors'

use Rack::Cors do
    # allow do
    #   origins 'http://localhost:3000'
  
    #   resource '/file/list_all/', :headers => 'x-domain-token'
    #   resource '/file/at/*',
    #       :methods => [:get, :post, :put, :delete, :options],
    #       :headers => 'x-domain-token',
    #       :expose  => ['Some-Custom-Response-Header'],
    #       :max_age => 600
    #       # headers to expose
    # end
  
    allow do
      origins 'http://localhost:3000'
      resource '*', :headers => :any, :methods => [:get, :post, :delete, :options]
    end
  end

# Load controllers
Dir[File.join(File.dirname(__FILE__), 'app/controllers', '**', '*.rb')].sort.each {|file| require file }

run App.router
