describe User do
  it { should have_many :accomplishments }
  it { should have_many :posts }
  #it { should have_many :groups }
  it { should validate_presence_of :username }
  it { should allow_mass_assignment_of :username }

  describe '#email' do
    subject { build :user, username: 'leo' }
    its(:email) { should == 'leo@thoughtworks.com' }
  end

  describe '#report_accomplishment' do
    let(:gap) { build :group }
    let(:leo) { build :user }
    let(:mathias) { build :user }

    before { Accomplishment.any_instance.should_receive(:save) }
    subject { mathias.report_accomplishment('fixed build', leo, gap) }

    its(:poster) { should == mathias }
    its(:receiver) { should == leo }
    its(:group) { should == gap }
    its(:description) { should == 'fixed build' }
  end
end
