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
end
