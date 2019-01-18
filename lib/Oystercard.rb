require_relative './journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY = 6
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
    # if touched in twice then they jumped fence on last journey, no error to be raised and a touch out will be trigerred with PENALTY as a station, then a normal touch in will be triggered
    touch_out("PENALTY") if in_journey?
    @travel_history << start_journey_hash(station)
  end

  def touch_out(station)
    # if touched out twice then they jumped fence on entry, no error to be raised and a touch out will be trigerred with PENALTY as a station!
    touch_in("PENALTY") unless in_journey?
    @station = station
    complete_travel_history
  end

  def complete_travel_history
    @travel_history[-1][:out] = end_journey_hash
    deduct(@fare = @journey.fare)
    @station = nil
  end

  def start_journey_hash(station)
    @journey = new_journey
    @station = station
    @journey.start_journey(@station)
  end

  def new_journey
    Journey.new
  end

  def end_journey_hash
    @journey.end_journey(@station)
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
