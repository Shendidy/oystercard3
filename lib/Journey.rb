class Journey

  MINIMUM_FARE = 1
  PENALTY = 6

  attr_reader :journey

  def initialize(journey = {})
    @journey = journey
  end

  def start_journey(station)
    @station = station
    record_travel("in")
  end

  def end_journey(station)
    @station = station
    record_travel("out")
    station
  end

  def record_travel(status)
    status == "in" ? @journey = {:in => @station} : @journey[:out] = @station
  end

  def fare
    @journey.count == 2 ? MINIMUM_FARE : @journey.count == 1 ? PENALTY : 0
  end

  def completed?
    @journey[:out] == nil ? false : true
  end
end
