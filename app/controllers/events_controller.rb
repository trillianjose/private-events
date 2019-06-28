class EventsController < ApplicationController
  def new
     @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      Attendance.create(user_id: params[:id],event_id: @event.id,role: "owner")
      flash[:info] = "Successfully created an event"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @user = User.last.events_as_owner
  end

  private

  def event_params
    params.require(:event).permit(:title, :description)
  end
end
