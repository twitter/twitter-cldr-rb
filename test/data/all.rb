Dir["#{File.dirname(__FILE__)}/**/*_test.rb"].each do |filename|
  require filename
end