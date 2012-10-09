describe AccomplishmentsHelper do
  describe '#description_max_length' do
    let(:validator) do
      stub({
        :class => ActiveModel::Validations::LengthValidator,
        :options => {:maximum => 99}
      })
    end

    before do
      Accomplishment.should_receive(:validators_on).with(:description).
      and_return [validator]
    end

    subject { description_max_length }
    it { should == 99 }
  end

  describe '#percentage_of_accomplishment_for' do
    let(:vini) { build :user }
    let(:project) { build :scope }
    let(:account) { build :scope }

    context 'when the user has no accomplishments' do
      specify { percentage_of_accomplishment_for(vini, project).should == '0.00%' }
      specify { percentage_of_accomplishment_for(vini, account).should == '0.00%' }
    end

    context 'when the user has some accomplishments' do
      before do
        vini.accomplishments = [
          build(:accomplishment, :scope => project),
          build(:accomplishment, :scope => project),
          build(:accomplishment, :scope => account)
        ]
      end

      specify { percentage_of_accomplishment_for(vini, project).should == '66.67%' }
      specify { percentage_of_accomplishment_for(vini, account).should == '33.33%' }
    end
  end

end
