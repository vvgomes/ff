describe AccomplishmentsController do
  let(:user) { create :user }
  let(:scopes) { [build(:scope)] }

  before do
    sign_in user
    Scope.stub(:all).and_return scopes
  end

  describe '#create' do
    let(:poster_id) { user.id }
    let(:receiver) { create(:user) }
    let(:scope_id) { create(:scope).id }

    context 'a valid accomplishment' do
      let(:attrs) {{
        :description => 'fixed build',
        :receiver_id => receiver.id,
        :scope_id => scope_id
      }}

      before { subject.stub(:referer).and_return path }

      context 'from /' do
        let(:path) { '/' }
        before { post :create, :accomplishment => attrs }

        it { should respond_with 302 }
        it { should redirect_to '/' }
        it { should set_the_flash.to 'Accomplishment reported!' }
        specify { Notifier.deliveries.last.to.should == [receiver.email] }
      end

      context 'from /:username' do
        let(:path) { '/mgusso' }
        before { post :create, :username => 'mgusso', :accomplishment => attrs }

        it { should respond_with 302 }
        it { should redirect_to user_path('mgusso') }
        it { should set_the_flash.to 'Accomplishment reported!' }
        specify { Notifier.deliveries.last.to.should == [receiver.email] }
      end
    end

    context 'an invalid accomplishment' do
      let(:attrs) {{
       :description => '',
       :receiver_id => receiver.id,
       :scope_id => scope_id
      }}

      before { post :create, :accomplishment => attrs }

      it { should render_template 'index' }
      it { assigns(:accomplishment).should_not be_valid }
      it { assigns(:scopes).should == scopes }
    end
  end
end
