require './config/environment.rb'
require 'securerandom'

class ApplicationController < Sinatra::Base

    def make_transactions(params, student)
        parent = student.parent
        params[:lessons].each do |id|
            transaction = Transaction.new
            lesson = Lesson.find(id[:id])
            transaction.lesson = lesson
            transaction.student = student
            if parent.students.count == 1
                transaction.cost = lesson.price
            elsif parent.students.count == 2
                transaction.cost = 40
            elsif parent.students.count == 3
                transaction.cost = 30
            elsif parent.students.count == 4
                transaction.cost = 15
            else
                transaction.cost = 10
            end
            transaction[:paid?] = false
            transaction.save
        end
    end

    configure do
        enable :sessions
        set :session_secret, "lX4iCMQygIKopCvepvJUUwiywmkvCn"
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    get '/test' do
        binding.pry
    end

    get '/' do
        redirect to '/login'
    end

    get '/login' do
        if Helpers.is_logged_in?(session)
            user = Helpers.current_user(session)
            if user.class == Parent
                redirect to '/parents/home'
            elsif user.class == Instructor
                redirect to '/instructors/home'
            end
        else
            erb :login
        end
    end

    get '/signup' do
        erb :signup
    end

    post '/login' do
        if Parent.find_by(email: params[:user][:email])
            user = Parent.find_by(email: params[:user][:email])
        elsif Instructor.find_by(email: params[:user][:email])
            user = Instructor.find_by(email: params[:user][:email])
        else
            session[:log_in_failed?] = true
            redirect to '/login'
        end
        if user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            session[:user_class] = user.class
        else
            session[:log_in_failed?] = true
        end
        redirect to '/login'
    end

    post '/logout' do
        session.clear
        redirect to '/login'
    end

    post '/signup' do
        parent = Parent.create(params[:parent])
        parent.balance = 0
        parent.save
        session[:user_id] = parent.id
        session[:user_class] = parent.class
        redirect to '/login'
    end

end