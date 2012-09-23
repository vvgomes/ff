describe AccomplishmentsHelper do
  describe '#description_max_length' do
    let(:foo) do
      stub({
        :class => ActiveModel::Validations::LengthValidator,
        :options => {:maximum => 99}
      })
    end
    
    before do
      Accomplishment.should_receive(:validators_on).with(:description).
      and_return [foo]
    end

    specify { description_max_length.should == 99 }
  end
end
