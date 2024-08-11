require "csv"
require "google/apis/civicinfo_v2"

puts "Event Manager Initialised!\n\n"

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = File.read("secret.key").strip

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

template_letter = File.read("form_letter.html")

contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  personal_letter = template_letter.gsub("FIRST_NAME", name)
  personal_letter.gsub!("LEGISLATORS", legislators)

  puts personal_letter
end
