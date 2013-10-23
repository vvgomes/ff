require 'json'

task :import => :environment do
  puts '> Iporting everyone...'
  JSON.parse(File.read(File.join(Rails.root, 'db', 'everyone.json'))).each do |raw|
    username = raw['mail'].split('@').first
    unless User.where(:username => username).first
      id = User.create(:username => username).id
      puts "> #{username} added (id = #{id})." 
    else
      puts "> #{username} is already in the database." 
    end
  end
  puts 'Done.'
end

task :import_names => :environment do
  puts '> Importing names...'
  JSON.parse(File.read(File.join(Rails.root, 'db', 'everyone.json'))).each do |raw|
    name = raw['name']
    username = raw['mail'].split('@').first
    puts "> #{username} will update with name = #{name}" 
    u = User.find_by_username(username)
    u.update_attribute(:name, name) if u
  end
  puts 'Done.'
end
