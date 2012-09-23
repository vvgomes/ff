describe AccomplishmentsController do
  let(:user) { create :user }
  let(:scopes) { [build(:scope)] }

  before do
    sign_in user
    Scope.stub(:all).and_return scopes
  end

  describe '#index' do
    let(:all) { 2.times.map { build :accomplishment } }

    before do
      Accomplishment.stub(:latest).and_return all
      get :index
    end

    it { should respond_with(:success) }
    it { assigns(:accomplishments).should =~ all }
    it { assigns(:accomplishment).should be_a_new Accomplishment }
    it { assigns(:scopes).should == scopes }
    it { should render_template :index }
    it { should_not set_the_flash }
  end

  describe '#create' do
    let(:poster_id) { user.id }
    let(:receiver_id) { create(:user).id }
    let(:scope_id) { create(:scope).id }
    
    before { post :create, accomplishment: attrs }

    context 'a valid accomplishment' do
      let(:attrs) {{
        :description => 'fixed build', 
        :receiver_id => receiver_id, 
        :scope_id => scope_id
      }}

      it { should respond_with(302) }
      it { should redirect_to accomplishments_path }
      it { should set_the_flash.to('Accomplishment reported!') }
    end

    context 'an invalid accomplishment' do
      let(:attrs) {{ 
       :description => '', 
       :receiver_id => receiver_id, 
       :scope_id => scope_id
      }}

      it { should render_template 'index' }
      it { assigns(:accomplishment).should_not be_valid }
      it { assigns(:scopes).should == scopes }
    end
  end
end
