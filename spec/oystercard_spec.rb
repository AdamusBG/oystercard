require 'oystercard'

describe Oystercard do

  it "Is an instance of the oystercard class" do
    expect(subject).to be_instance_of(Oystercard)
  end

  it "Has a balance of 0 when set up by default" do
    expect(subject.balance).to eq(0)
  end

  it "Responds to .top_up method" do
    expect(subject).to respond_to(:top_up).with(1).argument
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

end
