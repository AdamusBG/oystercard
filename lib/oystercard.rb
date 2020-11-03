class Oystercard
  attr_reader :balance, :entry_station, :journeys
  MAX_BALANCE = 90
  MIN_FOR_JOURNEY = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise StandardError.new "You cannot top up over the limit of £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    raise StandardError.new "You need at least £#{MIN_FOR_JOURNEY} to touch in" if @balance < MIN_FOR_JOURNEY
    @entry_station = station
  end

  def touch_out(station)
    deduct(1) # nb the magic number will need to be changed
    save_journey(station)
  end

  private
  def deduct(amount)
    @balance -= amount
  end

  def save_journey(exit_station)
    @journeys << { entry_station: @entry_station, exit_station: exit_station }
    @entry_station = nil
  end

end
