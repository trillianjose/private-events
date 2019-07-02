class AttendancesController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :find_event, only: [:index, :create]

  def index
    @assistents = @event.assistents
  end

  def create
    attendance = @event.assistent_relationships.build(user_id: current_user.id, role: 'assistent')

    if attendance.save
      flash[:success] = 'Check-in Successfully'
      redirect_to :root
    else
      flash[:danger] = 'Error in Check-in'
    end
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
