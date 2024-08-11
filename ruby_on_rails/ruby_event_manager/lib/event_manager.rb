puts "Event Manager Initialised!\n\n"

### Using "File" ###

# if File.exist?("event_attendees.csv")
#   puts "File found"
# else
#   puts "File not found"
# end

# # Read the whole file
# # contents = File.read("event_attendees.csv")
# # puts contents

# # Read the file line by line
# lines = File.readlines("event_attendees.csv")

# lines.each_with_index do |line, index|
#   next if index == 0

#   columns = line.split(",")
#   name = columns[2]
#   puts name
# end

# ### Using "CSV" ###
# require "csv"

# def clean_zipcode(zipcode)
#   # if the zip code is exactly five digits, assume that it is ok
#   # if the zip code is more than five digits, truncate it to the first five digits
#   # if the zip code is less than five digits, add zeros to the front until it becomes five digits

#   # if zipcode.nil?
#   #   "00000"
#   # elsif zipcode.length < 5
#   #   zipcode.rjust(5, "0")
#   # elsif zipcode.length > 5
#   #   zipcode[0..4]
#   # else
#   #   zipcode
#   # end

#   zipcode.to_s.rjust(5, "0")[0..4]
# end

# contents = CSV.open(
#   "event_attendees.csv",
#   headers: true,
#   header_converters: :symbol
# )

# contents.each do |row|
#   name = row[:first_name]
#   zipcode = clean_zipcode(row[:zipcode])

#   puts "#{name} #{zipcode}"
# end

### Using the Google Civic API Client ###

require "csv"
require "google/apis/civicinfo_v2"

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = File.read("./lib/secret.key").strip

  legislators = civic_info.representative_info_by_address(
    address: zipcode,
    levels: "country",
    roles: ["legislatorUpperBody", "legislatorLowerBody"]
  )
  legislators = legislators.officials

  legislator_names = legislators.map(&:name)

  legislator_names.join(", ")
rescue
  "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

contents = CSV.open(
  "event_attendees.csv",
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  puts "#{name.ljust(10)} #{zipcode} - #{legislators}"
end
