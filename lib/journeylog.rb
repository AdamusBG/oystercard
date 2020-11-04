class JourneyLog
  attr_reader :current_journey

  def initialize(journey_class: ) # JourneyLog.new(journey_class: Journey) to initialize
    @journey_class = journey_class
    @journeys = []
    @current_journey
  end

  def start(entry_station, exit_station = nil)
    @current_journey = @journey_class.new(entry_station, exit_station)
    @journeys << @current_journey
  end


  def finish(station)
    @current_journey.exit_station = station
    @current_journey = nil
  end

  def journeys
    @journeys.dup
  end

  def final_journey
    @journeys[-1]
  end

end
