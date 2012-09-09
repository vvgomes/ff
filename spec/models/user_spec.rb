describe User do
  it { should have_many :posts }
  it { should have_many :accomplishments }
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :username }
end
