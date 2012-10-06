class Notifier < ActionMailer::Base
  default from: 'ff@ff.com'

  def accomplishment a
    @accomplishment = a
    mail({
      :from => a.poster.email,
      :to => a.receiver.email, 
      :subject => "Accomplishment reported by #{a.poster.username}"
    })
  end
  
  def suggestion s
    @suggestion = s
    mail({
      :from => s.sender.email,
      :to => s.receiver.email, 
      :subject => "Improvements suggested by #{s.sender.username}"
    })
  end

end
