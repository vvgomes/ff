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

    context 'a valid accomplishment' do
      let(:attrs) { attributes_for(:accomplishment, :receiver_id => receiver_id) }
      before { post :create, accomplishment: attrs }

      it { should respond_with(302) }
      it { should redirect_to accomplishments_path }
      it { should set_the_flash.to('Accomplishment reported!') }
    end

    context 'an invalid accomplishment' do
      let(:invalid) { stub(:valid? => false) }
      let(:attrs) do
        attributes_for(:accomplishment, receiver_id: receiver_id, description: '')
      end

      before do
        receiver = build :user
        User.stub(:find_by_id).with(receiver_id.to_s).and_return receiver
        controller.current_user.stub(:report_accomplishment_for).with(receiver, '').and_return invalid
        post :create, accomplishment: attrs
      end

      it { should render_template 'new' }
      it { assigns(:accomplishment).should eq invalid }
    end


  end
end