describe Accomplishment do
  it { should belong_to :poster }
  it { should belong_to :receiver }
  it { should belong_to :scope }
  it { should have_many :thumbs_ups }

  it { should allow_mass_assignment_of :description }
  it { should allow_mass_assignment_of :receiver }
  it { should allow_mass_assignment_of :poster }
  it { should allow_mass_assignment_of :scope }
  it { should allow_mass_assignment_of :receiver_id }
  it { should allow_mass_assignment_of :poster_id }
  it { should allow_mass_assignment_of :scope_id }

  it { should validate_presence_of :description }
  it { should ensure_length_of(:description).is_at_most 140 }
  it { should validate_presence_of :receiver }
  it { should validate_presence_of :poster }
  it { should validate_presence_of :scope }

  context 'when the poster and the receiver are the same person' do
    let(:cheater) { build :user }
    subject do
      build(:accomplishment,
        poster: cheater, receiver: cheater, description: 'foo')
    end
    it { should_not be_valid }
  end

  describe '.latest' do
    it 'should order by newests first' do
      Accomplishment.should_receive(:order).with('created_at DESC')
      Accomplishment.latest
    end
  end
end
