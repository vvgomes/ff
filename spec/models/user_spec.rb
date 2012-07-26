describe User do
  it 'should validate its name' do
    User.new.should_not be_valid
    User.new(:name => 'Jairo').should be_valid
  end
end
