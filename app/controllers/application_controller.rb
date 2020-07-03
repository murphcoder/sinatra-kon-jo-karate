require './config/environment.rb'

class ApplicationController < Sinatra::Base

    configure do
        enable :sessions
        set :session_secret, "BananaJim"
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    get '/' do
        binding.pry
    end

end