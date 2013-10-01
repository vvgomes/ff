describe PlusOnesController do
  let(:user) { create :user }
  before { sign_in user }

  describe '#create' do
    let(:acc) { create(:accomplishment, :poster => user) }
    let(:path) { '/' }

    before do
      Accomplishment.stub(:find_by_id).with(acc.id.to_s).and_return acc
      subject.stub(:referer).and_return path
      post :create, :accomplishment_id => acc.id
    end

    it { should respond_with 302 }
    it { should redirect_to path }
    it { should set_the_flash.to '+1 given!' }
  end
end
