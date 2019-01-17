class Journey
  def initialize
    @journey = {}
  end

  def start_journey(station)
    @station = station
    record_travel("in")
  end

  def end_journey(station)
    # @station = station
    # record_travel("out")
    station
  end

  def record_travel(status)
    status == "in" ? @journey = {:in => @station} : @journey[:out] = @station
  end

  def calculate
  end

  def completed?
  end
end
