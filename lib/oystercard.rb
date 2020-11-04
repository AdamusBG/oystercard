require_relative './journeylog'
require_relative './journey'

class Oystercard
  attr_reader :balance, :journey_log, :journeys
  MAX_BALANCE = 90
  MIN_FOR_JOURNEY = 1

  def initialize(balance = 0)
    @balance = balance
    @journey_log = JourneyLog.new(journey_class: Journey)
  end

  def top_up(amount)
    raise StandardError.new "You cannot top up over the limit of £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    !!@journey_log.current_journey
  end

  def touch_in(station)
    deduct(@journey_log.current_journey.calculate_fare) if @journey_log.current_journey
    raise StandardError.new "You need at least £#{MIN_FOR_JOURNEY} to touch in" if @balance < MIN_FOR_JOURNEY
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.current_journey ? @journey_log.finish(station) : @journey_log.start(nil, station)
    deduct(@journey_log.final_journey.calculate_fare)
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
