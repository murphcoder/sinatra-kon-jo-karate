class InstructorController < ApplicationController

    get '/instructors' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            if @user.class == Instructor
                @instructors = Instructor.all
            elsif @user.class == Parent
                @instructors = @user.instructors
            end
            erb :'/instructors/instructors'
        else
            redirect to '/login'
        end
    end

    get '/instructors/home' do
        @user = Helpers.current_user(session)
        if @user.class == Instructor
            erb :'/instructors/home'
        elsif @user.class == Parent
            redirect to '/parents/home'
        else
            redirect to '/login'
        end
    end

    get '/instructors/new' do
        @user = Helpers.current_user(session)
        if @user.class == Instructor && @user.admin?
            erb :'/instructors/create'
        else
            'You are not permitted to view this page.'
        end
    end

    get '/instructors/:id' do
        @user = Helpers.current_user(session)
        @instructor = Instructor.find(params[:id])
        erb :'/instructors/show'
    end

    get '/instructors/:id/edit' do
        @user = Helpers.current_user(session)
        if @user.class == Instructor && @user.admin?
            @instructor = Instructor.find(params[:id])
            erb :'/instructors/edit'
        else
            'You are not permitted to view this page.'
        end
    end

    post '/instructors/new' do
        instructor = Instructor.create(params[:instructor])
        redirect to "/instructors/#{instructor.id}"
    end

    patch '/instructors/:id' do
        instructor = Instructor.update(params[:id], params[:instructor])
        redirect to "/instructors/#{instructor.id}"
    end

    delete '/instructors/:id' do
        user = Helpers.current_user(session)
        instructor = Instructor.find(params[:id])
        if user == instructor
            session.clear
        end
        instructor.destroy
        redirect to '/login'
    end

end