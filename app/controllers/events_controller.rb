class EventsController < ApplicationController
  layout 'dashboard'

  def index
    @events = policy_scope(Event).where(family_id: Family.find(params[:family_id]))
    @current_date = params[:start_date].present? ? params[:start_date].to_date : Date.today
    @events = @events.where(start_date: @current_date).order(:start_date)
  end

  def new
    @event = Event.new
    @event.family = Family.find(params[:family_id])
    @event_date = params[:start_date].to_date
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.family = Family.find(params[:family_id])
    authorize @event
    if @event.save
      redirect_to family_events_path(@event.family)
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_date, :end_date, :full_day, :place, :description, :color)
  end
end
