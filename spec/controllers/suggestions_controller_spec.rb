describe SuggestionsController do
  let(:user) { create :user }

  before { sign_in user }

  describe '#create' do
    let(:receiver) { create(:user) }

    before { post :create, suggestion: attrs }

    context 'a valid suggestion' do
      let(:attrs) {{
        :description => 'stop being late',
        :receiver_id => receiver.id
      }}

      it { should respond_with 302 }
      it { should redirect_to user_path(receiver.username) }
      it { should set_the_flash.to 'Suggestion sent' }
      it { assigns(:suggestion).should be_valid }
      specify { Notifier.deliveries.last.to.should == [receiver.email] }
    end

    context 'an invalid suggestion' do
      let(:attrs) {{
       :description => '',
       :receiver_id => receiver.id
      }}

      it { should respond_with 302 }
      it { should redirect_to user_path(receiver.username) }
      it { assigns(:suggestion).should_not be_valid }
    end
  end
end
