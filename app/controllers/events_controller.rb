class EventsController < ApplicationController
  layout 'dashboard'

  def index
    @events = policy_scope(Event).where(family_id: Family.find(params[:family_id]))
    @current_date = params[:start_date].present? ? params[:start_date].to_date : Date.today
    @events = @events.where(start_date: (@current_date.to_time...@current_date.to_time.change(hour: 24))).order(:start_date)
  end

  def show
    @event = Event.find(params[:id])
    authorize @event
  end

  def new
    @event = Event.new
    @event.family = Family.find(params[:family_id])
    @start_date = params[:start_date].to_time.change(hour: Time.now.hour)
    @end_date = @start_date + 1.hour
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.family = Family.find(params[:family_id])
    authorize @event
    if @event.save
      redirect_to family_events_path(@event.family, start_date: @event.start_date)
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
    authorize @event
  end

  def update
    @event = Event.find(params[:id])
    authorize @event
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    authorize @event
    @event.destroy
    redirect_to family_events_path(@event.family, start_date: @event.start_date)
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_date, :end_date, :full_day, :place, :description, :color)
  end
end
