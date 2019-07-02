class EventsController < ApplicationController
  before_action :logged_in_user, only: [:checkin, :create]
  before_action :find_event, only: [:checkin, :assistents]

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

  def event_params
    params.require(:event).permit(:title, :schedule, :description)
  end

  def find_event
    @event = Event.find(params[:event_id])
  end

end
