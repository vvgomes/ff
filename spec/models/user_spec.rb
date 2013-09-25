describe User do
  subject { build :user, :username => 'leo' }

  it { should have_many :accomplishments }
  it { should have_many :posts }
  it { should have_many :sent_suggestions }
  it { should have_many :received_suggestions }
  it { should have_many :thumbs_ups }

  it { should validate_presence_of :username }
  it { should allow_mass_assignment_of :username }

  its(:email) { should == 'leo@thoughtworks.com' }

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

  describe '#able_to_approve?' do
    let(:sugg) { build :suggestion, :receiver => receiver }

    context 'nil suggestion' do
      let(:sugg) { nil } 
      it { should_not be_able_to_approve sugg }
    end

    context 'existing suggestion' do
      before { sugg.stub(:useful?).and_return approved }
      
      context 'owned suggestion not approved' do
        let(:receiver) { subject }
        let(:approved) { false }
        it { should be_able_to_approve sugg }
      end

      context 'owned suggestion approved' do
        let(:receiver) { subject }
        let(:approved) { true }
        it { should_not be_able_to_approve sugg }
      end

      context 'suggestion to someone else not approved' do
        let(:receiver) { build :user }
        let(:approved) { false }
        it { should_not be_able_to_approve sugg }
      end

      context 'suggestion to someone else approved' do
        let(:receiver) { build :user }
        let(:approved) { true }
        it { should_not be_able_to_approve sugg }
      end
    end

  end

  describe '#give_thumbs_up' do
    let(:acc) { build :accomplishment }
    let(:leo) { build :user }
    subject { leo.give_thumbs_up acc }
    its(:accomplishment) { should == acc }
    its(:user) { should == leo }
  end

end
