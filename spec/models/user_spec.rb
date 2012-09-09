describe User do
  subject { build :user }
  
  it { should have_many :posts }
  it { should have_many :accomplishments }
  it { should validate_presence_of :email }
  it { should validate_presence_of :username }

  context 'with twitterish username' do
    it 'should be valid' do
      ['vvgomes', 'vvgomes_', 'vvgomes_42'].each do |u|
        subject.username = u
        subject.should be_valid
      end

    end
  end

  context 'with a not twitterish username' do
    it 'should not be valid' do  
      ['vv.gomes', '_vvgomes', '42_vvgomes'].each do |u|
        subject.username = u
        subject.should_not be_valid
      end
    end
  end

  context 'with a tiny username' do
    it 'should not be valid' do
      subject.username = ''
      subject.should_not be_valid
    end
  end

  context 'with a huge username' do
    it 'should not be valid' do
      subject.username = 17.times.map{'x'}.join
      subject.should_not be_valid
    end
  end
end
