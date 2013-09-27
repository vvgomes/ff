describe Accomplishment do
  it { should belong_to :poster }
  it { should belong_to :receiver }

  it { should allow_mass_assignment_of :description }
  it { should allow_mass_assignment_of :receiver }
  it { should allow_mass_assignment_of :poster }
  it { should allow_mass_assignment_of :receiver_id }
  it { should allow_mass_assignment_of :poster_id }

  it { should validate_presence_of :description }
  it { should ensure_length_of(:description).is_at_most 140 }
  it { should validate_presence_of :receiver }
  it { should validate_presence_of :poster }

  context 'when the poster and the receiver are the same person' do
    let(:cheater) { build :user }
    subject do
      build(:accomplishment,
        poster: cheater,
        receiver: cheater,
        description: 'foo')
    end
    it { should_not be_valid }
  end

  describe '.latest' do
    it 'should order by newests first' do
      Accomplishment.should_receive(:order).with('created_at DESC')
      Accomplishment.latest
    end
  end

  context 'before save' do
    let(:tags) { double }
    subject { build(:accomplishment, description: 'fixed build #gap #bfs') }
    before { subject.stub(:tag_list).and_return(tags) }
    it 'should parse tags' do
      tags.should_receive(:add).with(['gap', 'bfs'])
      subject.run_callbacks :save
    end
  end
end
