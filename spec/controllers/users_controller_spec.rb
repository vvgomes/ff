describe UsersController do
  let(:user) { create :user }
  before { session[:user_id] = user.id }

  describe '#index' do
    let(:all) { 2.times.map { build :accomplishment } }
    let(:from_user) { all.take(1) }
    let(:mathias) { build :user }

    context 'user profile' do
      before do
        User.stub(:find_by_username).with('mgusso').and_return mathias
        mathias.stub(:accomplishments).and_return from_user
        from_user.should_receive(:paginate).and_return from_user

        get :index, :username => 'mgusso'
      end

      it { should respond_with(:success) }
      it { assigns(:user).should == mathias }
      it { assigns(:accomplishments).should =~ from_user }
      it { assigns(:accomplishment).should be_a_new Accomplishment }
      it { assigns(:suggestion).should be_a_new Suggestion }
      it { should render_template :index }
      it { should_not set_the_flash }
    end
  end

end
