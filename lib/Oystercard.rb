require 'Journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_accessor :balance, :station, :travel_history, :fare

  def initialize
    @balance = 0
    @station = nil
    @travel_history = []
    @fare = 0
  end

  def top_up(amount)
    raise "Maximum balanced is £#{MAXIMUM_BALANCE}" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!@station
  end

  def touch_in(station)
    raise "insufficient funds < #{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
    raise "Already on a journey" if in_journey?
    @journey = Journey.new
    @station = station
    @travel_history << @journey.start_journey(station)
  end

  def touch_out(station)
     raise "Can't touch out twice!" unless in_journey?
     deduct(@fare = @journey.fare)
     @station = station
     @travel_history[-1][:out] = @journey.end_journey(station)
     @station = nil
  end

  def previous_trips
    @travel_history
  end

  def deduct(amount)
    @balance -= amount
  end

  def erase_station
    @station = nil
  end

  private :deduct, :erase_station
end
