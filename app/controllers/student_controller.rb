class StudentController < ApplicationController

    get '/students' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            erb :'/students/students'
        else
            redirect to 'login'
        end
    end

    get '/students/new' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            erb :'/students/create'
        else
            redirect to '/login'
        end
    end

    get '/students/:id' do
        @user = Helpers.current_user(session)
        @student = Student.find(params[:id])
        if @user.students.include?(@student) || @user.admin?
            erb :'/students/show'
        else
            'You are not permitted to view this page.'
        end
    end

    post '/students/new' do
        user = Helpers.current_user(session)
        student = Student.create(params[:student])
        if user.class == Instructor
            parent = Parent.create(params[:student])
            student.parent = parent
        else
            student.parent = user
        end
        redirect to "/students/#{student.id}"
    end

end