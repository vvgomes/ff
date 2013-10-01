describe PlusOne do
  it { should belong_to :accomplishment }
  it { should belong_to :user }
  it { should allow_mass_assignment_of :accomplishment }
  it { should allow_mass_assignment_of :user }
end
