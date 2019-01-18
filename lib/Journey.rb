class Journey

  MINIMUM_FARE = 1
  PENALTY = 6

  attr_reader :journey

  def initialize(journey = {}, entry = "Aldgate East")
    @journey = journey
    @journey_completed = true
    @entry = entry
  end

  def start_journey(station = @entry)
    @station = station
    record_travel("in")
  end

  def end_journey(station)
    @station = station
    record_travel("out")
    station
  end

  def record_travel(status)
    status == "out" ? @journey_completed = true : @journey_completed = false
    status == "in" ? @journey = {:in => @station} : @journey[:out] = @station
  end

  def fare
    # Penalties:
    # If entering while the last trip didn't have an out hash element.
    # If exiting while there is no entering record.
    #
    @journey[:in] != nil && @journey[:out] != nil && @journey[:in] != "PENALTY" && @journey[:out] != "PENALTY" ? MINIMUM_FARE : @journey[:in] == "PENALTY" || @journey[:out] == "PENALTY" ? PENALTY : 0
  end

  def complete?
    @journey_completed
  end
end
