describe StatsController do
  let(:user) { create :user }
  before { sign_in user }
  
  describe '#index' do
    let(:mathias) { double }
    let(:trends) { double(:to_json => '[]') }

    before { User.stub(:find_by_username).and_return(mathias) }
    before { mathias.stub(:accomplishment_trends).and_return(trends) }
    before { get :index, :username => 'mgusso' }

    it { should respond_with 200 }
    it { assigns(:user).should == mathias }
    it { assigns(:accomplishment_trends).should == '[]' }
    it { assigns(:accomplishment).should be_a_new Accomplishment }
    it { assigns(:suggestion).should be_a_new Suggestion }
  end
end 
