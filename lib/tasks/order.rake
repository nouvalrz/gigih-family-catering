namespace :order do
  desc "TODO"
  task cancel_order: :environment do
    puts "ORDER STATUS UPDATED"
    Order.update_status_order
  end

end
