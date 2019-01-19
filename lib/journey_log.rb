class JourneyLog

def initialize(journey_class = Journey)
  @journey = journey_class
  @journey_history = []
end

def start(station)
  @journey.new({}, station)
end

end
