describe ApplicationController do
  let(:user) { create :user }

  before do
    sign_in user
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
      it { should render_template :index }
      it { should_not set_the_flash }
    end
  end

  describe '#referer' do
    before { subject.request.stub(:referer).and_return url }

    context 'from /' do
      let(:url) { 'ff.com/' }
      its(:referer) { should == '/' }
    end

    context 'from /:username' do
      let(:url) { 'ff.com/mgusso' }
      its(:referer) { should == '/mgusso' }
    end
  end
end
