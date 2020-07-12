class RecoveryController < ApplicationController

    get '/recovery' do
        erb :'/recovery/recovery'
    end

    post '/recovery/send' do
        user = Parent.find_by(email: params[:email])
        if user == nil
            user = Instructor.find_by(email: params[:email])
        end
        user.recovery = SecureRandom.hex(30)
        user.save
        settings = File.new("email_settings.txt")
        options = eval("{#{settings.read}}")
        Mail.defaults do
            delivery_method :smtp, options
        end
        Mail.deliver do
            to user.email
            from 'konjobilling@gmail.com'
            subject 'Password Recovery'
            body "Click http://localhost:9393/recovery/#{user.recovery} to reset your password."
        end
        "Check your email for password reset instructions."
    end

    get '/recovery/:recovery' do
        @user = Parent.find_by(recovery: params[:recovery])
        if @user == nil
            @user = Instructor.find_by(recovery: params[:recovery])
        end
        if !@user.nil?
            erb :'/recovery/password'
        else
            "Your password recovery link was incorrect. Please recheck your email."
        end
    end

    post '/recovery/password' do
        user = Parent.find_by(id: params[:user_id])
        if user == nil
            user = Instructor.find(params[:user_id])
        end
        user.password = params[:password]
        user.recovery = nil
        user.save
        redirect to '/login'
    end

end