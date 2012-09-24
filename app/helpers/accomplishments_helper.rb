module AccomplishmentsHelper
  extend Memoist

  def description_max_length
    Accomplishment.validators_on(:description).find do |validator|
      validator.class == ActiveModel::Validations::LengthValidator
    end.options[:maximum]
  end

  def percentage_of_accomplishment_for user, scope
    total_accomplishments = user.accomplishments.size.to_f
    return "0.00%" unless total_accomplishments > 0

    accomplishments_for_scope = user.accomplishments_for(scope).size.to_f
    percentage = accomplishments_for_scope / total_accomplishments * 100
    "%0.2f" % [percentage] + "%"
  end

  def total_accomplishments
    @user.accomplishments.count
  end

  memoize :total_accomplishments
end
