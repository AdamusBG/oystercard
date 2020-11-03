require_relative './journey'

class Oystercard
  attr_reader :balance, :current_journey, :journeys
  MAX_BALANCE = 90
  MIN_FOR_JOURNEY = 1

  def initialize(balance = 0)
    @balance = balance
    @current_journey = nil
    @journeys = []
  end

  def top_up(amount)
    raise StandardError.new "You cannot top up over the limit of £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    !!@current_journey
  end

  def touch_in(station)
    end_journey if @current_journey
    raise StandardError.new "You need at least £#{MIN_FOR_JOURNEY} to touch in" if @balance < MIN_FOR_JOURNEY
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    @current_journey ? @current_journey.set_exit_station(station) : @current_journey = Journey.new(nil, station)
    end_journey
  end

  private
  def end_journey
    deduct(@current_journey.calculate_fare)
    save_journey
    @current_journey = nil
  end

  def deduct(amount)
    @balance -= amount
  end

  def save_journey
    @journeys << @current_journey
  end

end
