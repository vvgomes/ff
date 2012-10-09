describe Suggestion do
  it { should belong_to :sender }
  it { should belong_to :receiver }

  it { should allow_mass_assignment_of :description }
  it { should allow_mass_assignment_of :receiver }
  it { should allow_mass_assignment_of :sender }
  it { should allow_mass_assignment_of :receiver_id }
  it { should allow_mass_assignment_of :sender_id }
  it { should allow_mass_assignment_of :useful }
  
  it { should validate_presence_of :receiver }
  it { should validate_presence_of :sender }

  it { should respond_to :description }
  it { should respond_to :description= }
  it { should respond_to :useful? }
  it { should respond_to :useful= }

  it { should_not be_useful }

  describe '#approve!' do
    before { subject.approve! }
    it { should be_useful }
  end

  context 'description validation' do
    subject { build :suggestion, :id => id, :description => desc }

    context 'for new undescribed' do
      let(:id) { nil }
      let(:desc) { nil }
      it { should_not be_valid }
    end

    context 'for new described' do
      let(:id) { nil }
      let(:desc) { 'stop being late!' }
      it { should be_valid }
    end

    context 'for existing undescribed' do
      let(:id) { 99 }
      let(:desc) { nil }
      it { should be_valid }
    end
  end

  context 'when the sender and the receiver are the same person' do
    let(:cheater) { build :user }
    subject do
      build(:suggestion,
        sender: cheater, receiver: cheater, description: 'foo') 
    end
    it { should_not be_valid }
  end
end
