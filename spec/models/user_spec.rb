describe User do
  let(:vinicius) { build :user }
  let(:guilherme) { build :user }

  it { should have_many :posts }
  it { should have_many :accomplishments }
  it { should validate_presence_of :email }
  it { should validate_presence_of :username }

  context 'with twitterish username' do
    it 'should be valid' do
      ['vvgomes', 'vvgomes_', 'vvgomes_42'].each do |u|
        vinicius.username = u
        vinicius.should be_valid
      end

    end
  end

  context 'with a not twitterish username' do
    it 'should not be valid' do
      ['vv.gomes', '_vvgomes', '42_vvgomes'].each do |u|
        vinicius.username = u
        vinicius.should_not be_valid
      end
    end
  end

  context 'with a tiny username' do
    it 'should not be valid' do
      vinicius.username = ''
      vinicius.should_not be_valid
    end
  end

  context 'with a huge username' do
    it 'should not be valid' do
      vinicius.username = 17.times.map{'x'}.join
      vinicius.should_not be_valid
    end
  end

  describe '#report_accomplishment_for' do
    subject { guilherme.report_accomplishment_for vinicius, 'Created a cool feedback tool!' }

    its(:poster) { should eq guilherme }
    its(:receiver) { should eq vinicius }
    its(:description) { should eq 'Created a cool feedback tool!' }
    it { should be_persisted }
  end

end
