describe Accomplishment do
  it { should validate_presence_of :description }
  it { should validate_presence_of :receiver }
  it { should validate_presence_of :poster }
end
