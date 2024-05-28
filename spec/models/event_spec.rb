require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "#past?" do
    context "when the event has already ended" do
      it "returns true" do
        event = build(:event, end_date: 1.day.ago)

        expect(event.past?).to be true
      end
    end

    context "when the event has not yet ended" do
      it "returns false" do
        event = build(:event, end_date: 1.day.from_now)

        expect(event.past?).to be false
      end
    end
  end

  describe ".any_on?" do
    context "when there is an event on the given date" do
      it "returns true" do
        create(:event, start_date: Date.today, end_date: Date.today + 1.hour)

        expect(Event.any_on?(Date.today)).to be true
      end
    end

    context "when there is no event on the given date" do
      it "returns false if there is no event on the given date" do
        create(:event, start_date: Date.today + 1.day, end_date: Date.today + 1.day + 1.hour)

        expect(Event.any_on?(Date.today)).to be false
      end
    end
  end

  describe ".events_this_week" do
    it "returns the events that are happening this week" do
      family = create(:family)
      event = create(:event, family: family, start_date: Date.today.beginning_of_week, end_date: Date.today.beginning_of_week + 1.hour)

      expect(Event.events_this_week(family)).to eq([event])
    end

    it "does not return events that are not happening this week" do
      family = create(:family)
      create(:event, family: family, start_date: Date.today.beginning_of_week - 1.day, end_date: Date.today.beginning_of_week - 1.day + 1.hour)

      expect(Event.events_this_week(family)).to be_empty
    end
  end
end
