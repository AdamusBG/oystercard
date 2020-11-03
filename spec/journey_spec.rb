require 'journey'

describe Journey do
  let(:station1) { double :station1 }
  let(:station2) { double :station2 }
  let(:my_journey) { Journey.new(station1) }
  let(:no_entrance_journey) { Journey.new(nil, station2) }

  it "Is an instance of the Journey class" do
    expect(my_journey).to be_instance_of(Journey)
  end

  it "Stores the input entry station correctly" do
    expect(my_journey.entry_station).to eq(station1)
  end

  context "exit_station" do
    it "Has no exit station by default" do
      expect(my_journey.exit_station).to eq(nil)
    end

    it "Responds to .set_exit_station" do
      expect(my_journey).to respond_to(:set_exit_station).with(1).argument
    end

    it "Stores the exit station correctly" do
      my_journey.set_exit_station(station2)
      expect(my_journey.exit_station).to eq(station2)
    end
  end

  context "#calculate_fare" do
    it "Responds to .calculate_fare" do
      expect(my_journey).to respond_to(:calculate_fare)
    end

    it "Will charge penalty fare if there is no exit station" do
      expect(my_journey.calculate_fare).to eq(Journey::PENALTY_FARE)
    end

    it "Will charge penalty fare if there is no entry station" do
      expect(no_entrance_journey.calculate_fare).to eq(Journey::PENALTY_FARE)
    end

    it "Will charge min fare if there is both entrance and exit stations" do
      my_journey.set_exit_station(station2)
      expect(my_journey.calculate_fare).to eq(Journey::MIN_FARE)
    end
  end

end
