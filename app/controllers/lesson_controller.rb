class LessonController < ApplicationController

    def make_lesson(params, lesson)
        lesson.start_time = params[:lesson][:start_time]
        lesson.end_time = params[:lesson][:end_time]
        lesson.price = params[:lesson][:price]
        lesson.start_date = "#{params[:lesson][:date][:start_year]}-#{params[:lesson][:date][:start_month]}-#{params[:lesson][:date][:start_day]}"
        lesson.end_date = "#{params[:lesson][:date][:end_year]}-#{params[:lesson][:date][:end_month]}-#{params[:lesson][:date][:end_day]}"
        if params[:lesson][:location] == "new"
            location = Location.create(params[:lesson][:new_location])
        else
            location = Location.find(params[:lesson][:location])
        end
        lesson.location = location
        lesson.students.clear
        if !params[:lesson][:students].nil?
            params[:lesson][:students].each do |student|
                lesson.students << Student.find(student[:id])
            end
        end
        lesson.instructors.clear
        if !params[:lesson][:instructors].nil?
            params[:lesson][:instructors].each do |instructor|
                lesson.instructors << Instructor.find(instructor[:id])
            end
        end
        lesson.save
        lesson
    end

    get '/lessons' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @lessons = Lesson.all
            erb :'/lessons/lessons'
        else
            redirect to '/login'
        end
    end

    get '/lessons/new' do
        @user = Helpers.current_user(session)
        if @user.class == Instructor && @user.admin?
            @students = Student.all
            @locations = Location.all
            @instructors = Instructor.all
            erb :'/lessons/create'
        else
            'You are not permitted to view this page.'
        end
    end

    get '/lessons/signup' do
        @user = Helpers.current_user(session)
        if @user.class == Parent
            @lessons = Lesson.all
            erb :'/lessons/signup'
        else
            'You are not permitted to view this page.'
        end
    end

    get '/lessons/:id' do
        @user = Helpers.current_user(session)
        @lesson = Lesson.find(params[:id])
        email_array = @lesson.parents.uniq.collect {|e| e.email}
        @email_link = "mailto:#{email_array.join(", ")}"
        erb :'/lessons/show'
    end
    
    get '/lessons/:id/edit' do
        @user = Helpers.current_user(session)
        if @user.class == Instructor && @user.admin?
            @lesson = Lesson.find(params[:id])
            @students = Student.all
            @locations = Location.all
            @instructors = Instructor.all
            erb :'/lessons/edit'
        else
            'You are not permitted to view this page.'
        end
    end

    post '/lessons/new' do
        lesson = make_lesson(params, Lesson.new)
        redirect to "/lessons/#{lesson.id}"
    end

    patch '/lessons/:id' do
        lesson = make_lesson(params, Lesson.find(params[:id]))
        redirect to "/lessons/#{lesson.id}"
    end

    delete '/lessons/:id' do
        Lesson.destroy(params[:id])
        redirect to '/login'
    end

end