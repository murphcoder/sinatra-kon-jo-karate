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
            erb :'/parents/edit'
        else
            'You are not permitted to view this page.'
        end
    end

    post '/parents/new' do
        parent = Parent.create(params[:parent])
        if !params[:student][:name].empty?
            if params[:student][:address].empty?
                params[:student][:address] = parent.address
            end
            student = Student.create(params[:student])
            parent.students << student
        end
        redirect to "/parents/#{parent.id}"
    end

    patch '/parents/:id' do
        parent = Parent.update(params[:id], params[:parent])
        parent.students.clear
        params[:students].each do |child|
            parent.students << Student.find(child[:id])
        end
        if !params[:student][:name].empty?
            student = Student.create(params[:student])
            parent.students << student
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
            student.delete
        end
        parent.delete
        redirect to '/login'
    end
        

end