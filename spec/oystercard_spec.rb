require 'oystercard'

describe Oystercard do

  it "Is an instance of the oystercard class" do
    expect(subject).to be_instance_of(Oystercard)
  end

  it "Has a balance of 0 when set up by default" do
    expect(subject.balance).to eq(0)
  end

end
