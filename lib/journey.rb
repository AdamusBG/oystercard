class Journey
  MIN_FARE = 1
  PENALTY_FARE = 6
  attr_reader :entry_station, :exit_station

  def initialize(entry_station, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def calculate_fare
    return PENALTY_FARE if penalty?
    return MIN_FARE
  end

  def set_exit_station(exit_station)
    @exit_station = exit_station
  end

  private
  def penalty?
    !@entry_station || !@exit_station
  end

end
