class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def index
    @eventspast = Event.past
    @eventsupcoming = Event.upcoming
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events_as_owner.build(event_params)

    if @event.save
      @event.create_owner_relationship(user_id: current_user.id, role: 'owner')

      flash[:info] = 'Successfully created an event'
      redirect_to :root
    else
      render 'new'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :schedule, :description)
  end

end
