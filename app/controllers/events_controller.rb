class EventsController < ApplicationController
  def index
    @events = Event.all.order(:schedule)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      Attendance.create(user_id: session[:user_id], event_id: @event.id, role: 'owner')

      flash[:info] = 'Successfully created an event'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def checkin
    event = Event.find(params[:event_id])
    attendance = Attendance.new(user_id: session[:user_id], event_id: event.id, role: 'assistent')

    if attendance.save
      flash[:info] = 'Check-in Successfully'
      redirect_to root_url
    else
      flash[:danger] = 'Error in Check-in'
    end
  end

  def show
  end

  private

  def event_params
    params.require(:event).permit(:title, :schedule, :description)
  end
end
