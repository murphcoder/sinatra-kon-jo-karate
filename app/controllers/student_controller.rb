class StudentController < ApplicationController

    get '/students' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @students = Student.all
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

    get '/students/:id/edit' do
        @user = Helpers.current_user(session)
        @student = Student.find(params[:id])
        if @user.students.include?(@student) || @user.admin?
            erb :'/students/edit'
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

    patch '/students/:id' do
        student = Student.update(params[:id], params[:student])
        if params[:parent]
            parent = student.parent
            parent.update(params[:parent])
        end
        redirect to "/students/#{student.id}"
    end

    delete '/students/:id' do
        Student.delete(params[:id])
        redirect to '/login'
    end

end