describe AccomplishmentsController do
  let(:user) { create :user }
  
  before { sign_in user }

  describe '#index' do
    let(:all) { 2.times.map { build :accomplishment } }

    before do
      Accomplishment.stub_chain(:order).with('created_at DESC').and_return all
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
    let(:attrs) do
      attributes_for(:accomplishment).merge({
        poster_id: poster_id, receiver_id: receiver_id
      })
    end

    before { post :create, accomplishment: attrs }

    it { should respond_with(302) }
    it { should redirect_to accomplishments_path }
    it { should set_the_flash.to('Accomplishment reported!') }
  end
end