class Helpers

    def self.current_user(session)
        if session[:user_class] == Parent
            user = Parent.find(session[:user_id])
        elsif session[:user_class] == Instructor
            user = Instructor.find(session[:user_id])
        end
        user
    end

    def self.is_logged_in?(session)
        !!session[:user_id]
    end

end