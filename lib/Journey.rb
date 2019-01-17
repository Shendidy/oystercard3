class Journey

  def initialize()
    @journey = {}
  end

  def start_journey(station)
    check_errors(at_entry)
    @station = station
    record_travel("in")
  end

  def end_journey(station)
    check_errors(at_exit)
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

  def check_errors(when)
    case when
    when "at_entry"
      raise "insufficient funds < #{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
      raise "Already on a journey" if in_journey?
    when "at_exit"
      raise "Can't touch out twice!" unless in_journey?
    end
  end

  private :check_errors
end
