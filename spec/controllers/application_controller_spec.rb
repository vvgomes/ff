describe ApplicationController do
  let(:user) { create :user }
  before { session[:user_id] = user.id }

  describe '#index' do
    let(:all) { 2.times.map{ build(:accomplishment) } }

    context 'home' do
      before do
        Accomplishment.should_receive(:latest).and_return(all)
        all.stub(:paginate).and_return(all)

        get :index
      end

      it { should respond_with(:success) }
      it { assigns(:user).should == subject.current_user }
      it { assigns(:accomplishments).should =~ all }
      it { assigns(:accomplishment).should be_a_new Accomplishment }
      it { should render_template :index }
      it { should_not set_the_flash }
    end

    context 'tag' do
      let(:from_gap) { all.take(1) }

      before do
        Accomplishment.stub(:latest).and_return(all)
        all.should_receive(:tagged_with).with('gap').and_return(from_gap)
        from_gap.stub(:paginate).and_return(from_gap)

        get :index, :tag => 'gap'
      end

      it { should respond_with(:success) }
      it { assigns(:user).should == subject.current_user }
      it { assigns(:tag).should == 'gap' }
      it { assigns(:accomplishments).should =~ from_gap }
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
