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
      it { should set_the_flash.to 'Suggestion sent!' }
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

  describe '#edit' do
    let(:sugg) { create :suggestion, :receiver => receiver }
    let(:accomplishments) { [build(:accomplishment)] }
    
    before do
      Accomplishment.stub_chain(:latest, :paginate).and_return accomplishments
      Suggestion.stub(:find_by_id).with(sugg.id.to_s).and_return sugg
      get :edit, :id => sugg.id
    end

    context 'from the receiver' do
      let(:receiver) { user }

      context 'once' do
        it { should respond_with 200 }
        it { should render_template :edit }
        it { assigns(:suggestion).should == sugg }
        it { assigns(:user).should == user }
        it { assigns(:accomplishment).should be_a_new Accomplishment }
        it { assigns(:accomplishments).should == accomplishments }
      end

      context 'twice' do
        before do
          sugg.approve!
          sugg.should_not_receive :approve!
          get :edit, :id => sugg.id
        end

        it { should respond_with 302 }
        it { should redirect_to '/' }
      end
    end
    
    context 'from someone else' do
      let(:receiver) { create :user }
      it { should respond_with 302 }
      it { should redirect_to '/' }
    end
  end

  describe '#update' do
    let(:sugg) { create :suggestion, :receiver => receiver }

    before do
      Suggestion.stub(:find_by_id).with(sugg.id.to_s).and_return sugg
      put :update, id: sugg.id
    end

    context 'from the receiver' do
      let(:receiver) { user }

      context 'once' do
        it { should respond_with 302 }
        it { should redirect_to '/' }
        it { should set_the_flash.to 'Suggestion approved!' }
        specify { sugg.should be_useful }
        specify { Notifier.deliveries.last.to.should == [sugg.sender.email] }
      end

      context 'twice' do
        before do
          sugg.should_not_receive :approve!
          put :update, id: sugg.id
        end

        it { should respond_with 302 }
        it { should redirect_to '/' }
        specify { sugg.should be_useful }
      end
    end

    context 'from someone else' do
      let(:receiver) { create :user }
      it { should respond_with 302 }
      it { should redirect_to '/' }
      specify { sugg.should_not be_useful }
    end
  end

end
