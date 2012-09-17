describe Group do
  it { should have_many :accomplishments }
  it { should have_and_belong_to_many :users }
  it { should allow_mass_assignment_of :name }  
end
