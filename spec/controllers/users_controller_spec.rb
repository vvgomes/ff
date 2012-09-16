describe UsersController do
  let(:user) { create :user }
  before { sign_in user }

  describe '#update' do
    context 'valid parameters' do
      let(:attrs) { attributes_for :user }
      before { put :update, id: user.id, user: attrs }

      it { should respond_with 302 }
      it { should redirect_to accomplishments_path }
      it { should set_the_flash.to('Personal information updated.') }
    end

  end

end