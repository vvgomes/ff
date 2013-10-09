task :import => :environment do
  ids = {}
  User.all.each do |user|
    username = user.username.downcase
    ids[username] ? ids[username] << user.id : ids[username] = [user.id]
  end
  puts 'Results:'
  ids.each{ |k, v| puts "#{k} => #{v}" if v.size > 1 }
  puts 'Done.'
end
