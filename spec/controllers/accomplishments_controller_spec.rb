describe AccomplishmentsController do
  let(:user) { create :user }
  
  before { sign_in user }

  describe '#index' do
    let(:all) { 2.times.map { build :accomplishment } }

    before do
      Accomplishment.stub(:all).and_return all
      get :index
    end

    it { should respond_with(:success) }
    it { assigns(:accomplishments).should =~ all }
    it { should render_template :index }
    it { should_not set_the_flash }
  end
end