require 'station'

describe Station do
  let(:my_station) { Station.new("Bank") }

  it "Is an instance of the Station class" do
    expect(my_station).to be_instance_of(Station)
  end

  it "Has accessable name variable" do
    expect(my_station.name).to eq("Bank")
  end

  it "Has accessible zone variable at 1 by default" do
    expect(my_station.zone).to eq(1)
  end

end
