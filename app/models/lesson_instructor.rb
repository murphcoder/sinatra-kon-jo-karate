class LessonInstructor < ActiveRecord::Base
    belongs_to :lesson
    belongs_to :instructor
end