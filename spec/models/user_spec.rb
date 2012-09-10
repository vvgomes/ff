describe User do
  let(:vinicius) { build :user }
  let(:guilherme) { build :user }

  it { should validate_presence_of :username }
  it { should have_many :posts }
  it { should have_many :accomplishments }
  it { should allow_mass_assignment_of :username }
  it { should allow_mass_assignment_of :email }
  it { should allow_mass_assignment_of :name }

  it 'should default name to username' do
    user = User.new username: 'vvgomes'
    user.name.should eq 'vvgomes'
  end

  describe '#report_accomplishment_for' do
    subject { guilherme.report_accomplishment_for vinicius, 'Created a cool feedback tool!' }

    its(:poster) { should eq guilherme }
    its(:receiver) { should eq vinicius }
    its(:description) { should eq 'Created a cool feedback tool!' }
    it { should be_persisted }
  end

end
