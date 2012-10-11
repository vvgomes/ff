describe ThumbsUp do
  let(:leo) { build :user }
  let(:acc) { build :accomplishment }
  
  subject { build :thumbs_up, :user => leo, :accomplishment => acc }
  
  it { should belong_to :user }
  it { should belong_to :accomplishment }

  it { should allow_mass_assignment_of :user }
  it { should allow_mass_assignment_of :user_id }
  it { should allow_mass_assignment_of :accomplishment }
  it { should allow_mass_assignment_of :accomplishment_id }

  it { should validate_presence_of :user }
  it { should validate_presence_of :accomplishment }

  context 'when the user is involved in the accomplishment' do

    context 'as poster' do
      before { acc.poster = leo }
      it { should_not be_valid }
    end

    context 'as receiver' do
      before { acc.receiver = leo }
      it { should_not be_valid }
    end

    context 'as supporter' do
      let(:previous) { build :thumbs_up, :user => leo, :accomplishment => acc }
      before { acc.thumbs_ups << previous }
      it { should_not be_valid }
    end
  end

  describe '#==' do
    it { should == build(:thumbs_up, :user => leo, :accomplishment => acc) }
  end

end
