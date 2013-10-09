namespace :usernames do
  task :downcase => :environment do
    puts 'Downcasing everyone...'
    User.all.each do |user|
      user.username = user.username.downcase
      user.save
    end
    puts 'Done.'
  end
  
  namespace :check do
    task :duplication => :environment do
      ids = {}
      User.all.each do |user|
        username = user.username.downcase
        ids[username] ? ids[username] << user.id : ids[username] = [user.id]
      end
      puts 'Results:'
      ids.each{ |k, v| puts "#{k} => #{v}" if v.size > 1 }
      puts 'Done.'
    end

    task :unformated => :environment do
      puts 'Resuls:'
      User.all.each do |user|
        puts "#{user.username}" unless user.username == user.username.downcase
      end
      puts 'Done.'
    end
  end
end
