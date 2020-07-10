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
            @lessons = Lesson.all
            erb :'/students/create'
        else
            redirect to '/login'
        end
    end

    get '/students/:id' do
        @user = Helpers.current_user(session)
        @student = Student.find(params[:id])
        if @user.students.include?(@student) || (@user.class == Instructor && @user.admin?)
            erb :'/students/show'
        else
            'You are not permitted to view this page.'
        end
    end

    get '/students/:id/edit' do
        @user = Helpers.current_user(session)
        @student = Student.find(params[:id])
        @lessons = Lesson.all
        if @user.students.include?(@student) || @user.admin?
            erb :'/students/edit'
        else
            'You are not permitted to view this page.'
        end
    end

    post '/students/new' do
        @user = Helpers.current_user(session)
        @student = Student.create(params[:student])
        if params[:parent]
            parent = Parent.create(params[:parent])
            parent.students << @student
        else
            @user.students << @student
        end
        if !params[:lessons].nil?
            make_transactions(params, @student)
        end
        redirect to "/students/#{@student.id}"
    end

    patch '/students/:id' do
        student = Student.update(params[:id], params[:student])
        student.lessons.clear
        if params[:parent]
            parent = student.parent
            parent.update(params[:parent])
        end
        if !params[:lessons].nil?
            make_transactions(params, student)
        end
        redirect to "/students/#{student.id}"
    end

    delete '/students/:id' do
        student = Student.find(params[:id])
        student.transactions.each {|t| t.destroy}
        student.destroy
        redirect to '/login'
    end

end