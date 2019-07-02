class AttendancesController < ApplicationController
  before_action :logged_in_user, only: [:checkin]
  before_action :find_event, only: [:checkin, :assistents]


  # def new
  #   @assistents = @event.assistents
  # end
  #
  # def create
  #   attendance = @event.assistent_relationships.build(user_id: current_user.id, role: 'assistent')
  #
  #   if attendance.save
  #     flash[:success] = 'Check-in Successfully'
  #     redirect_to :root
  #   else
  #     flash[:danger] = 'Error in Check-in'
  #   end
  # end
  #
  # def show
  # end
  def checkin
    attendance = @event.assistent_relationships.build(user_id: current_user.id, role: 'assistent')

    if attendance.save
      flash[:success] = 'Check-in Successfully'
      redirect_to :root
    else
      flash[:danger] = 'Error in Check-in'
    end
  end

  def assistents
    @assistents = @event.assistents
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end


end
