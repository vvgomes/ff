describe Accomplishment do
  it { should validate_presence_of :description }
  it { should validate_presence_of :receiver }
  it { should validate_presence_of :poster }

  context 'when the poster and the receiver are the same person' do
    let(:cheater) { build :user }
    subject { build :accomplishment, poster: cheater, receiver: cheater, description: 'oh' }
    it { should_not be_valid }
  end
end
