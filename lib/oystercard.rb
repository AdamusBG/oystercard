class Oystercard
  attr_reader :balance, :entry_station
  MAX_BALANCE = 90
  MIN_FOR_JOURNEY = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
  end

  def top_up(amount)
    raise StandardError.new "You cannot top up over the limit of £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station ? true : false
  end

  def touch_in(station)
    raise StandardError.new "You need at least £#{MIN_FOR_JOURNEY} to touch in" if @balance < MIN_FOR_JOURNEY
    @entry_station = station
    @in_journey = true
  end

  def touch_out
    deduct(1)
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
