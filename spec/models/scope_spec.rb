describe Scope do
  it { should have_many :accomplishments }
  it { should allow_mass_assignment_of :name }
  it { should validate_presence_of :name }
end
