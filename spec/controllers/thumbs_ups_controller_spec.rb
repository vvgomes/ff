describe ThumbsUpsController do
  let(:user) { create :user }
  let(:path) { '/' }
  
  before do
    subject.stub(:referer).and_return path
    sign_in user
  end

  describe '#create' do
    let(:attrs) {{ :accomplishment_id => acc.id }}

    context 'successfuly' do
      let(:acc) { create :accomplishment }
      before { post :create, :thumbs_up => attrs }
      it { should respond_with 302 }
      it { should redirect_to path }
      it { should set_the_flash.to '+1 Thumbs Up!' }
    end

    context 'failed' do
      let(:acc) { create :accomplishment, :poster => user }
      before { post :create, :thumbs_up => attrs }
      it { should respond_with 302 }
      it { should redirect_to path }
      it { should_not set_the_flash }
    end
  end

end
