class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, :only => [:show]

  def show
  end

  private

  def require_authorized_for_current_lesson

    this_lesson = current_lesson.section.course

    if !this_lesson.user.enrolled_in?(this_lesson)
      redirect_to course_path(this_lesson), :alert => 'You must enroll to view this course.'
    end
  end


  helper_method :current_lesson

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

end
