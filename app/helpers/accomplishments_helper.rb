module AccomplishmentsHelper
  def description_max_length
    Accomplishment.validators_on(:description).find do |validator|
      validator.class == ActiveModel::Validations::LengthValidator
    end.options[:maximum]
  end
end
