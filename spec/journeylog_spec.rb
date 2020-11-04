require 'journeylog'

describe JourneyLog do
  let(:journey){ double :journey } #this may need to have some methods
  let(:station){ double :station }
  let(:journey_class){double :journey_class, new: journey}
  subject {described_class.new(journey_class: journey_class)}

  it "Can start a journey" do
    expect(journey_class).to receive(:new).with(station, nil)
    subject.start(station)
  end

  it "Can record a journey" do
    allow(journey_class).to receive(:new).and_return(journey)
    subject.start(station)
    expect(subject.journeys).to include(journey)
  end

end