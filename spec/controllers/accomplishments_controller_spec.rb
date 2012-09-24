describe AccomplishmentsController do
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

    context 'user profile' do
      let(:mathias) { build :user }
      before do
        User.stub(:find_by_username).with('mgusso').and_return mathias
        mathias.stub(:latest_accomplishments).and_return from_user
        get :index, :username => 'mgusso'
      end

      it { should respond_with(:success) }
      it { assigns(:user).should == mathias }
      it { assigns(:accomplishments).should =~ from_user }
      it { assigns(:accomplishment).should be_a_new Accomplishment }
      it { assigns(:scopes).should == scopes }
      it { should render_template :index }
      it { should_not set_the_flash }
    end
  end

  describe '#create' do
    let(:poster_id) { user.id }
    let(:receiver_id) { create(:user).id }
    let(:scope_id) { create(:scope).id }
    
    context 'a valid accomplishment' do
      let(:attrs) {{
        :description => 'fixed build', 
        :receiver_id => receiver_id, 
        :scope_id => scope_id
      }}

      context 'from home' do
        before do
          subject.request.stub(:referer).and_return 'ff.com/'
          post :create, :accomplishment => attrs 
        end

        it { should respond_with(302) }
        it { should redirect_to '/' }
        it { should set_the_flash.to('Accomplishment reported!') }
      end

      context 'from user profile' do
        before do
          subject.request.stub(:referer).and_return 'ff.com/mgusso'
          post :create, :username => 'mgusso', :accomplishment => attrs 
        end

        it { should respond_with(302) }
        it { should redirect_to user_path('mgusso') }
        it { should set_the_flash.to('Accomplishment reported!') }
      end
    end

    context 'an invalid accomplishment' do
      let(:attrs) {{ 
       :description => '', 
       :receiver_id => receiver_id, 
       :scope_id => scope_id
      }}

      before { post :create, :accomplishment => attrs }

      it { should render_template 'index' }
      it { assigns(:accomplishment).should_not be_valid }
      it { assigns(:scopes).should == scopes }
    end
  end
end
