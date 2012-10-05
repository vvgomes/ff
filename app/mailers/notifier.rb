class Notifier < ActionMailer::Base
  default from: 'fastfeedback@gmail.com'

  def accomplishment a
    @accomplishment = a
    mail({
      :to => a.receiver.email, 
      :subject => "Accomplishment reported by #{a.poster.username}"
    })
  end
  
  def suggestion s
    @suggestion = s
    mail({
      :to => s.receiver.email, 
      :subject => "Improvements suggested by #{s.sender.username}"
    })
  end

end
