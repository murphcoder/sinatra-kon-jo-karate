class BillingController < ApplicationController

    get '/balance' do
        @user = Helpers.current_user(session)
        erb :'/billing/bill'
    end

    get '/billing/pay' do
        @user = Helpers.current_user(session)
        @charge = @user.balance
        @user.transactions.each do |t|
            t[:paid?] = true
            t.save
        end
        erb :'/billing/pay'
    end

    post '/billing/add' do
        @user = Helpers.current_user(session)
        @student = Student.find(params[:signup][:student])
        if !params[:lessons].nil?
            make_transactions(params, @student)
        end
        erb :'/billing/bill'
    end

    delete '/billing/remove' do
        params[:transactions].each do |id|
            t = Transaction.find(id)
            student = t.student
            lesson = t.lesson
            student.lessons.delete(lesson)
            lesson.students.delete(student)
        end
        redirect to '/balance'
    end

end