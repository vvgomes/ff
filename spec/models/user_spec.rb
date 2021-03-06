describe User do
  subject { build :user, :username => 'leo' }

  it { should have_many :accomplishments }
  it { should have_many :posts }
  it { should have_many :sent_suggestions }
  it { should have_many :received_suggestions }
  it { should have_many :plus_ones }

  it { should validate_presence_of :username }
  it { should allow_mass_assignment_of :username }

  describe '#report_accomplishment' do
    let(:leo) { build :user}
    let(:mathias) { build :user }

    before { Accomplishment.any_instance.should_receive(:save) }
    subject { mathias.report_accomplishment('fixed build', leo) }

    its(:poster) { should == mathias }
    its(:receiver) { should == leo }
    its(:description) { should == 'fixed build' }
  end

  describe '#peers' do
    let(:leo) { build :user}
    let(:mathias) { build :user }
    let(:tramonta) { build :user }
    before { User.stub(:all).and_return [leo, tramonta, mathias] }

    it 'should give all users but itself' do
      leo.peers.should =~ [tramonta, mathias]
      mathias.peers.should =~ [tramonta, leo]
      tramonta.peers.should =~ [leo, mathias]
    end
  end

  describe '#suggest' do
    let(:leo) { build :user }
    let(:mathias) { build :user }

    before { Suggestion.any_instance.should_receive(:save) }
    subject { mathias.suggest('stop being late', leo) }

    its(:sender) { should == mathias }
    its(:receiver) { should == leo }
    its(:description) { should == 'stop being late' }
  end

  describe '#score' do
    before { 5.times { subject.accomplishments << build(:accomplishment) } } 
    its(:score) { should == 5 }
  end
  
  describe '#allowed_to_delete?' do
    let(:accomplishment) { build(:accomplishment, :poster => author) }

    context 'an accomplishment posted by him' do
      let(:author) { subject }
      it { should be_allowed_to_delete accomplishment }
    end

    context 'an accomplishment posted by someone else' do
      let(:author) { build(:user) }
      it { should_not be_allowed_to_delete accomplishment }
    end
  end

  describe '#delete_accomplishment' do
    let(:fixed_build) { build(:accomplishment) }

    context 'when allowed' do
      before { subject.stub(:allowed_to_delete?).and_return true }
      specify do
        fixed_build.should_receive(:destroy)
        subject.delete_accomplishment(fixed_build)
      end
    end

    context 'when not allowed' do
      before { subject.stub(:allowed_to_delete?).and_return false }
      specify do
        fixed_build.should_not_receive(:destroy) 
        subject.delete_accomplishment(fixed_build)
      end
    end

  end

  describe '#allowed_to_plus_one?' do
    let(:accomplishment) { build(:accomplishment, :poster => author, :receiver => receiver) }

    context 'an accomplishment posted by him' do
      let(:author) { subject }
      let(:receiver) { build(:user) }
      it { should_not be_allowed_to_plus_one accomplishment }
    end

    context 'an accomplishment posted to him' do
      let(:author) { build(:user) }
      let(:receiver) { subject }
      it { should_not be_allowed_to_plus_one accomplishment }
    end

    context 'an accomplishment he is not involved' do
      let(:author) { build(:user) }
      let(:receiver) { build(:user) }
      
      context 'giving +1 for the first time' do
        it { should be_allowed_to_plus_one accomplishment }
      end

      context 'giving +1 again' do
        let(:from_leo) { build(:plus_one, :accomplishment => accomplishment, :user => subject) }
        before { accomplishment.plus_ones << from_leo }
        it { should_not be_allowed_to_plus_one accomplishment }
      end
    end
  end

  describe '#plus_one' do
    let(:fixed_build) { build(:accomplishment) }

    context 'when allowed' do
      before { subject.stub(:allowed_to_plus_one?).and_return true }
      specify do
        PlusOne.should_receive(:new).
          with(:accomplishment => fixed_build, :user => subject).
          and_return(stub(:save => true))
        subject.plus_one(fixed_build)
      end
    end

    context 'when not allowed' do
      before { subject.stub(:allowed_to_plus_one?).and_return false }
      specify do
        PlusOne.should_not_receive(:new)
        subject.plus_one(fixed_build)
      end
    end
  end

  describe '#tags' do
    let(:received) { build(:accomplishment, :tag_list => ['gap']) }
    let(:posted) { build(:accomplishment, :tag_list => ['lms', 'gap']) }

    before { subject.stub(:accomplishments).and_return [received] }
    before { subject.stub(:posts).and_return [posted] }

    its(:tags) { should == ['gap', 'lms'] }
  end

end

