describe ThumbsUp do
  it { should belong_to :user }
  it { should belong_to :accomplishment }

  it { should allow_mass_assignment_of :user }
  it { should allow_mass_assignment_of :user_id }
  it { should allow_mass_assignment_of :accomplishment }
  it { should allow_mass_assignment_of :accomplishment_id }
end
