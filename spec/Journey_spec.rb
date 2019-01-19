require 'journey'
require 'oystercard'

describe Journey do
  let(:station1) {double :station}
  let(:station2) {double :station}

  it 'starts a journey' do
    subject.start_journey(station1)
    expect(subject.record_travel("in")).to eq ({in: station1})
  end

  it 'finishes a journey' do
    subject.start_journey(station1)
    subject.finish(station2)
    expect(subject.journey).to eq ({in: station1, out: station2})
  end

  context "Checking if juorneys are completed" do
    it 'return completed = false if not touched out' do
      subject.start_journey(station1)
      expect(subject).not_to be_complete
    end

    it 'return completed = true if touched out' do
      subject.start_journey(station1)
      subject.finish(station2)
      expect(subject).to be_complete
    end
  end

  context "calculating fares and penalties" do
    it 'calculate the fare without any journeys' do
      expect(subject.fare).to eq (0)
    end

    it 'calculate the fare of a completed journey (minimum fare for now)' do
      subject.start_journey(station1)
      subject.finish(station2)
      expect(subject.fare).to eq (Journey::MINIMUM_FARE)
    end
  end
end
