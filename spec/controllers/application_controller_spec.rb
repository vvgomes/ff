describe ApplicationController do
  let(:user) { create :user }
  let(:scopes) { [build(:scope)] }

  before do
    sign_in user
    Scope.stub(:all).and_return scopes
  end

  describe '#index' do
    let(:all) { 2.times.map { build :accomplishment } }
    let(:from_user) { all.take(1) }

    context 'home' do
      before do
        Accomplishment.stub(:latest).and_return all
        all.should_receive(:paginate).and_return all

        get :index
      end

      it { should respond_with(:success) }
      it { assigns(:user).should == subject.current_user }
      it { assigns(:accomplishments).should =~ all }
      it { assigns(:accomplishment).should be_a_new Accomplishment }
      it { assigns(:scopes).should == scopes }
      it { should render_template :index }
      it { should_not set_the_flash }
    end
  end
end