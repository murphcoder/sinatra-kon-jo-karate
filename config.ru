require_relative './config/environment.rb'

if ActiveRecord::Base.connection.migration_context.needs_migration?
    raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use ParentController
use StudentController
use LocationController
use LessonController
use InstructorController
use BillingController
use RecoveryController
run ApplicationController