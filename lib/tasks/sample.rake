namespace :example do
  desc "says hello to the world"
  task say_hello: :environment do
     puts "hello world HAHAHAH"
  end
end