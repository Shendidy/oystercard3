require "Oystercard"

describe Oystercard do

  describe '#balance' do

    it "have a default new balance of £0" do
      expect(subject.balance).to eq 0
    end

  end

  describe '#top_up' do

    it "be able to top up the balance" do
      expect { subject.top_up 10 }.to change{ subject.balance }.by 10
    end

    it "not be able to have a balance over £90" do
      subject.top_up(80)
      expect { subject.top_up(11) }
      .to raise_error "Maximum balanced is £#{Oystercard::MAXIMUM_BALANCE}"
    end

   end

   describe '#touch_in_touch_out' do

     let(:station) { double :xyz }

     before(:each) do
       @card = subject
       @card.top_up(15)
     end

     it "start out of the journey" do
       expect(@card).not_to be_in_journey
     end

     it "change the in_use attribute to true" do
       @card.touch_in(station)
       expect(@card).to be_in_journey
     end

     it "change the in_use attribute to false" do
       @card.touch_in(station)
       @card.touch_out(station)
       expect(@card).not_to be_in_journey
     end

     it "not be able to touch in if balance under £1" do
       card = Oystercard.new
       expect { card.touch_in(station) }
       .to raise_error "insufficient funds < #{Oystercard::MINIMUM_BALANCE}"
     end

     it "charge the user when touch_out" do
       initial_balance = subject.balance
       subject.touch_in(station)
       subject.touch_out(station)
       new_balance = subject.balance
       expect(initial_balance - new_balance).to eq subject.fare
     end

     it "forget where I have travelled from" do
       subject.touch_in(station)
       expect { subject.touch_out(station) }
       .to change { subject.station }.to be_nil
     end

     it "in_journey return true" do
       subject.touch_in(station)
       expect(subject.in_journey?).to be true
     end

     let(:travel_history){ { in: station, out: station } }

     it "see all previous trips" do
       subject.touch_in(station)
       subject.touch_out(station)
       subject.touch_in(station)
       subject.touch_out(station)
       expect(subject.previous_trips).to include travel_history
     end

     it "has an empty travel_history by default" do
      expect(subject.previous_trips).to eq []
     end

   end
end
