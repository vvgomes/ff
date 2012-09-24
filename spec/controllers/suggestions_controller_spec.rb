describe SuggestionsController do
  let(:user) { create :user }

  before { sign_in user }

  describe '#create' do
    let(:sender_id) { user.id }
    let(:receiver_id) { create(:user).id }
    
    before { post :create, suggestion: attrs }

    context 'a valid suggestion' do
      let(:attrs) {{
        :description => 'stop being late', 
        :receiver_id => receiver_id
      }}

      it { should respond_with(302) }
      it { should redirect_to accomplishments_path }
      it { should set_the_flash.to('Suggestion sent!') }
    end

    context 'an invalid suggestion' do
      let(:attrs) {{ 
       :description => '', 
       :receiver_id => receiver_id
      }}

      it { should render_template 'accomplishments/index' }
      it { assigns(:suggestion).should_not be_valid }
    end
  end
end
