require 'oystercard'

describe Oystercard do
  let(:card_with_money) { Oystercard.new(10) }
  let(:station) { double :station }

  it "Is an instance of the oystercard class" do
    expect(subject).to be_instance_of(Oystercard)
  end

  it "Has a balance of 0 when set up by default" do
    expect(subject.balance).to eq(0)
  end

  it "Balance increases by 5 when topped up by 5" do
    expect { subject.top_up(5) }.to change { subject.balance }.by(5)
  end

  it "Maximum balance constant should be set at 90" do
    expect(Oystercard::MAX_BALANCE).to eq(90)
  end

  it "Should raise an error if topped up above maximum balance" do
    maximum_balance = Oystercard::MAX_BALANCE
    subject.top_up(maximum_balance)
    expect { subject.top_up(1) }.to raise_error(StandardError)
  end

  it "Is not in journey by default" do
    expect(subject.in_journey?).to eq(false)
  end

  it "Is in journey after touching in" do
    card_with_money.touch_in(station)
    expect(card_with_money.in_journey?).to eq(true)
  end

  it "Ends journey after touching out" do
    card_with_money.touch_in(station)
    card_with_money.touch_out(station)
    expect(card_with_money.in_journey?).to eq(false)
  end

  it "Should raise an error if touching in with insufficient funds" do
    expect { subject.touch_in(station) }.to raise_error(StandardError)
  end

  it "Should deduct £1 after touching out" do
    card_with_money.touch_in(station)
    expect { card_with_money.touch_out(station) }.to change { card_with_money.balance }.by(-1)
  end

  it "Should remember entry station after touching in" do
    card_with_money.touch_in(station)
    expect(card_with_money.journey_log.current_journey.entry_station).to eq(station)
  end

  it "Should have an empty journey list by default" do
    expect(subject.journey_log.journeys.length).to eq(0)
  end

  it "Touching in should create one journey" do
    expect { card_with_money.touch_in(station) }.to change { card_with_money.journey_log.journeys.length }.by(1)
  end

  it "Should charge penalty fare of £#{Journey::PENALTY_FARE} if touching out with no touch in" do
    expect {card_with_money.touch_out(station) }.to change { card_with_money.balance }.by(-Journey::PENALTY_FARE)
  end

  it "Should charge penalty fare of £#{Journey::PENALTY_FARE} if touching in twice" do
    card_with_money.touch_in(station)
    expect {card_with_money.touch_in(station) }.to change { card_with_money.balance }.by(-Journey::PENALTY_FARE)
  end

end
