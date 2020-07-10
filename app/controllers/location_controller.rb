class LocationController < ApplicationController

    get '/locations' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @locations = Location.all
            erb :'/locations/locations'
        else
            redirect to '/login'
        end
    end

    get '/locations/:id' do
        @user = Helpers.current_user(session)
        @location = Location.find(params[:id])
        erb :'/locations/show'
    end

    get '/locations/:id/edit' do
        @user = Helpers.current_user(session)
        if @user.class == Instructor && @user.admin?
            @location = Location.find(params[:id])
            erb :'/locations/edit'
        else
            'You are not permitted to view this page.'
        end
    end

    patch '/locations/:id' do
        locale = Location.update(params[:id], params[:location])
        params[:lessons].each do |session|
            Lesson.find(session[:id]).location = locale
        end
        redirect to "/locations/#{locale.id}"
    end

    delete '/locations/:id' do
        location = Location.find(params[:id])
        location.lessons.each do |lesson|
            lesson.destroy
        end
        location.destroy
        redirect to '/login'
    end

end