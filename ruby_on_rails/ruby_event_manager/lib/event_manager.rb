require "csv"
require "google/apis/civicinfo_v2"
require "erb"

puts "Event Manager Initialised!\n\n"

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = File.read("secret.key").strip

  civic_info.representative_info_by_address(
    address: zipcode,
    levels: "country",
    roles: ["legislatorUpperBody", "legislatorLowerBody"]
  ).officials
rescue
  "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def save_thankyou_letter(id, form_letter)
  Dir.mkdir("output") unless Dir.exist?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename, "w") do |file|
    file.puts(form_letter)
  end
end

contents = CSV.open(
  "event_attendees.csv",
  headers: true,
  header_converters: :symbol
)

template_letter = File.read("form_letter.erb")
erb_template = ERB.new(template_letter)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thankyou_letter(id, form_letter)
end
