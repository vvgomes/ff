describe User do
  subject { build :user, :username => 'leo' }

  it { should have_many :accomplishments }
  it { should have_many :posts }
  it { should validate_presence_of :username }
  it { should allow_mass_assignment_of :username }
  its(:email) { should == 'leo@thoughtworks.com' }

  describe '#report_accomplishment' do
    let(:leo) { build :user}
    let(:mathias) { build :user }
    let(:project) { build :scope }

    before { Accomplishment.any_instance.should_receive(:save) }
    subject { mathias.report_accomplishment('fixed build', leo, project) }
 
    its(:poster) { should == mathias }
    its(:receiver) { should == leo }
    its(:scope) { should == project }
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

  describe '#accomplishments_by_scope' do
    let(:leo) { build :user}
    
    let(:project) { build :scope, :name => 'project' }
    let(:office) { build :scope, :name => 'office' }

    let(:for_project) { build :accomplishment, :scope => project }
    let(:for_office) { build :accomplishment, :scope => office }
    
    before do
      leo.accomplishments << for_project 
      leo.accomplishments << for_office
    end
    
    specify { leo.accomplishments_for(project).should == [for_project]}
    specify { leo.accomplishments_for(office).should == [for_office] }
  end

  describe '#latest_accomplishments' do
    let(:first) { build :accomplishment, :created_at => 2.minutes.ago }
    let(:last)  { build :accomplishment, :created_at => 1.minutes.ago }

    before { subject.stub(:accomplishments).and_return [first, last] }

    its(:latest_accomplishments) { should == [last, first] }
  end
end
