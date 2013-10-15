describe StatsController do
  let(:user) { create :user }
  before { sign_in user }
  
  describe '#index' do
    let(:mathias) { double }
    before { User.stub(:find_by_username).and_return(mathias) }
    before { get :index, :username => 'mgusso' }
    it { should respond_with 200 }
    it { assigns(:user).should == mathias }
  end
end 
