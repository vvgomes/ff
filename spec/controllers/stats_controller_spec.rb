describe StatsController do
  let(:user) { create :user }
  before { sign_in user }
  
  describe '#index' do
    let(:mathias) { double }
    let(:trends_for_acc) { double(:to_json => "[['Jan', 5]]") }
    let(:trends_for_posts) { double(:to_json => "[['Jan', 3]]") }
    let(:tag_counts) { double(:to_json => "[['gap', 1]]") }
    let(:given_tag_counts) { double(:to_json => "[['bfs', 1]]") }

    before { User.stub(:find_by_username).and_return(mathias) }
    before { mathias.stub(:accomplishment_trends).and_return(trends_for_acc) }
    before { mathias.stub(:post_trends).and_return(trends_for_posts) }
    before { mathias.stub(:tag_counts).and_return(tag_counts) }
    before { mathias.stub(:given_tag_counts).and_return(given_tag_counts) }
    before { get :index, :username => 'mgusso' }

    it { should respond_with 200 }
    it { assigns(:user).should == mathias }
    it { assigns(:accomplishment_trends).should == "[['Jan', 5]]" }
    it { assigns(:post_trends).should == "[['Jan', 3]]" }
    it { assigns(:tag_counts).should == "[['gap', 1]]"}
    it { assigns(:given_tag_counts).should == "[['bfs', 1]]"}
    it { assigns(:accomplishment).should be_a_new Accomplishment }
    it { assigns(:suggestion).should be_a_new Suggestion }
  end
end 
