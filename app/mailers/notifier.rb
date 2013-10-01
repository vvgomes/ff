class Notifier < ActionMailer::Base
  default from: 'ff@ff.com'

  def accomplishment a
    @accomplishment = a
    mail({
      :from => a.poster.email,
      :to => a.receiver.email, 
      :subject => "You've got a new Accomplishment!"
    })
  end
  
  def suggestion s
    @suggestion = s
    mail({
      :from => s.sender.email,
      :to => s.receiver.email, 
      :subject => "You've got a new Improvement Suggestion!"
    })
  end
end
