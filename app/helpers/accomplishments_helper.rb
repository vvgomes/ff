module AccomplishmentsHelper

  def description_max_length
    Accomplishment.validators_on(:description).find do |validator|
      validator.class == ActiveModel::Validations::LengthValidator
    end.options[:maximum]
  end

  def percentage_of_accomplishment_for user, scope
    return "0.00%" unless (total = user.score.to_f) > 0
    percentage = user.score_for(scope).to_f / total * 100
    "%0.2f" % [percentage] + "%"
  end

end
