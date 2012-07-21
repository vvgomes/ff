describe User do
  it 'should not be valid without name' do
    User.new.should_not be_valid
  end

  it 'should be valid with a name' do
    User.new(:name => 'Jairo').should be_valid
  end
end
