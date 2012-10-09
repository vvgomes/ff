describe Notifier do
  let(:tc) { build :user, :username => 'tc' }
  let(:leo) { build :user, :username => 'leo' }

  describe '.accomplishment' do
    subject { Notifier.accomplishment(acc) }
    let(:acc) { build :accomplishment, :poster => tc, :receiver => leo }
    its(:subject) { should == "You've got a new Accomplishment!" }
    its(:from) { should == ['tc@thoughtworks.com'] }
    its(:to) { should == ['leo@thoughtworks.com'] }
  end

  describe '.suggestion' do
    subject { Notifier.suggestion(sug) }
    let(:sug) { build :suggestion, :sender => tc, :receiver => leo, :id=>99 }
    its(:subject) { should == "You've got a new Improvement Suggestion!" }
    its(:from) { should == ['tc@thoughtworks.com'] }
    its(:to) { should == ['leo@thoughtworks.com'] }
  end

end
