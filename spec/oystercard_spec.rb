require 'oystercard'

describe Oystercard do

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

  it "Balance decreases by correct amount when deduct method is called" do
    expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
  end

  it "Is not in journey by default" do
    expect(subject.in_journey?).to eq(false)
  end

  it "Is in journey after touching in" do
    subject.touch_in
    expect(subject.in_journey?).to eq(true)
  end

  it "Ends journey after touching out" do
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey?).to eq(false)
  end

end
