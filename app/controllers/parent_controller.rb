class ParentController < ApplicationController

    get '/parents' do
        @user = Helpers.current_user(session)
        if @user.class == Instructor
            @parents = Parent.all
            erb :'/parents/parents'
        else
            'You are not permitted to view this page.'
        end
    end

    get '/parents/home' do
        @user = Helpers.current_user(session)
        if @user.class == Instructor
            redirect to '/instructors/home'
        elsif @user.class == Parent
            erb :'/parents/home'
        else
            redirect to '/login'
        end
    end

    get '/parents/new' do
        @user = Helpers.current_user(session)
        if @user.class == Instructor && @user.admin?
            @lessons = Lesson.all
            erb :'/parents/create'
        else
            'You are not permitted to view this page.'
        end
    end

    get '/parents/:id' do
        @user = Helpers.current_user(session)
        if @user.class == Instructor && @user.admin?
            @parent = Parent.find(params[:id])
            erb :'/parents/show'
        else
            'You are not permitted to view this page.'
        end
    end

    get '/parents/:id/edit' do
        @user = Helpers.current_user(session)
        if (@user.class == Parent && @user.id == params[:id].to_i) || (@user.class == Instructor && @user.admin?)
            @parent = Parent.find(params[:id])
            @lessons = Lesson.all
            erb :'/parents/edit'
        else
            'You are not permitted to view this page.'
        end
    end

    post '/parents/new' do
        parent = Parent.create(params[:parent])
        parent.balance = 0
        if !params[:student][:name].empty?
            student = Student.create(params[:student])
            parent.students << student
        end
        redirect to "/parents/#{parent.id}"
    end

    patch '/parents/:id' do
        parent = Parent.update(params[:id], params[:parent])
        parent.students.each do |student|
            if params[:students] == nil || !params[:students].map {|s| s[:id].to_i}.include?(student.id)
                student.transactions.each {|t| t.destroy}
                student.destroy
            end
        end
        if !params[:student][:name].empty?
            student = Student.create(params[:student])
            parent.students << student
            make_transactions(params, student)
        end
        parent.save
        if parent == Helpers.current_user(session)
            redirect to '/parents/home'
        else
            redirect to "/parents/#{parent.id}"
        end
    end

    delete '/parents/:id' do
        parent = Parent.find(params[:id])
        if Helpers.current_user(session) == parent
            session.clear
        end
        parent.students.each do |student|
            student.transactions.each {|t| t.destroy}
            student.destroy
        end
        parent.destroy
        redirect to '/login'
    end
        

end