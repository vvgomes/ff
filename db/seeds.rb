['Project', 'Account', 'Office', 'Company', 'Community'].each do |name|
  Scope.new(:name => name).save
end
