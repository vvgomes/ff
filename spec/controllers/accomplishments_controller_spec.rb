describe AccomplishmentsController do
  let(:user) { create :user }

  before { sign_in user }

  describe '#index' do
    let(:all) { 2.times.map { build :accomplishment } }

    before do
      Accomplishment.stub(:latest).and_return all
      get :index
    end

    it { should respond_with(:success) }
    it { assigns(:accomplishments).should =~ all }
    it { assigns(:accomplishment).should be_a_new Accomplishment }
    it { should render_template :index }
    it { should_not set_the_flash }
  end

  describe '#create' do
    let(:poster_id) { user.id }
    let(:receiver_id) { create(:user).id }
    let(:group_id) { create(:group).id }
    
    before { post :create, accomplishment: attrs }

    context 'a valid accomplishment' do
      let(:attrs) do
        {description: 'fixed build', receiver_id: receiver_id, group_id: group_id}
      end
      it { should respond_with(302) }
      it { should redirect_to accomplishments_path }
      it { should set_the_flash.to('Accomplishment reported!') }
    end

    context 'an invalid accomplishment' do
      let(:attrs) do
        {description: '', receiver_id: receiver_id, group_id: group_id}
      end
      it { should render_template 'new' }
      it { assigns(:accomplishment).should_not be_valid }
    end
  end
end
