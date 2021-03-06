describe Suggestion do
  it { should belong_to :sender }
  it { should belong_to :receiver }

  it { should allow_mass_assignment_of :description }
  it { should allow_mass_assignment_of :receiver }
  it { should allow_mass_assignment_of :sender }
  it { should allow_mass_assignment_of :receiver_id }
  it { should allow_mass_assignment_of :sender_id }
  
  it { should validate_presence_of :receiver }
  it { should validate_presence_of :sender }

  it { should respond_to :description }
  it { should respond_to :description= }
end
