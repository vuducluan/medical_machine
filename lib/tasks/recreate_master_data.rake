require "csv"
namespace :master_data  do
  desc "create master_data"
  task :recreate => :environment do
    DATA_TYPES = %w(fields brands)
    MASTER_DATA_CSV_FILE_PATH = "db/master_data/"

    puts "recreate mater_data processing ..."
    puts "processing destroy all old data ..."
    DATA_TYPES.each do |type|    
      type.classify.constantize.destroy_all
    end

    puts "processing create data ..."
    DATA_TYPES.each do |type|    
      CSV.foreach("#{MASTER_DATA_CSV_FILE_PATH}#{type}.csv", headers: true) do |row|
        new_object = type.classify.constantize.new
        new_object.assign_attributes row.to_hash
        new_object.save validate: false
      end
    end
    puts "creating master data is OK"
  end
end
