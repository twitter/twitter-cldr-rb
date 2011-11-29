# encoding: utf-8

require File.dirname(__FILE__) + '/../test_helper.rb'

class TestCldrDataTimezones < Test::Unit::TestCase
  define_method 'test: timezones :de' do
    codes = [:"Etc/Unknown", :"Europe/Tirane", :"Asia/Yerevan",
             :"America/Curacao", :"Antarctica/South_Pole",
             :"Antarctica/Vostok", :"Antarctica/DumontDUrville",
             :"Europe/Vienna", :"Europe/Brussels", :"Africa/Ouagadougou",
             :"Atlantic/Bermuda", :"Europe/Zurich", :"Pacific/Easter",
             :"America/Havana", :"Atlantic/Cape_Verde", :"Indian/Christmas",
             :"Asia/Nicosia", :"Africa/Djibouti", :"Europe/Copenhagen",
             :"Africa/Algiers", :"Africa/Cairo", :"Africa/El_Aaiun",
             :"Atlantic/Canary", :"Africa/Addis_Ababa", :"Pacific/Fiji",
             :"Atlantic/Faeroe", :"Asia/Tbilisi", :"Africa/Accra",
             :"Europe/Athens", :"Atlantic/South_Georgia", :"Asia/Hong_Kong",
             :"Asia/Baghdad", :"Asia/Tehran", :"Europe/Rome",
             :"America/Jamaica", :"Asia/Tokyo", :"Asia/Bishkek",
             :"Indian/Comoro", :"America/St_Kitts", :"Asia/Pyongyang",
             :"America/Cayman", :"Asia/Aqtobe", :"America/St_Lucia",
             :"Europe/Vilnius", :"Europe/Luxembourg", :"Africa/Tripoli",
             :"Europe/Chisinau", :"Asia/Macau", :"Indian/Maldives",
             :"America/Mexico_City", :"Africa/Niamey", :"Asia/Muscat",
             :"Europe/Warsaw", :"Atlantic/Azores", :"Europe/Lisbon",
             :"America/Asuncion", :"Asia/Qatar", :"Indian/Reunion",
             :"Europe/Bucharest", :"Europe/Moscow", :"Asia/Yekaterinburg",
             :"Asia/Novosibirsk", :"Asia/Krasnoyarsk", :"Asia/Yakutsk",
             :"Asia/Vladivostok", :"Asia/Sakhalin", :"Asia/Kamchatka",
             :"Asia/Riyadh", :"Africa/Khartoum", :"Asia/Singapore",
             :"Atlantic/St_Helena", :"Africa/Mogadishu", :"Africa/Sao_Tome",
             :"America/El_Salvador", :"Asia/Damascus", :"Asia/Dushanbe",
             :"America/Port_of_Spain", :"Asia/Taipei", :"Africa/Dar_es_Salaam",
             :"Europe/Uzhgorod", :"Europe/Kiev", :"Europe/Zaporozhye",
             :"America/Indiana/Knox", :"Asia/Tashkent", :"America/St_Vincent",
             :"America/St_Thomas"]
  
    timezones = Cldr::Data::Timezones.new(:de)[:timezones]
    assert (timezones.keys - codes).empty? && (codes - timezones.keys).empty?
    assert_equal({ :city => 'Wien' }, timezones[:"Europe/Vienna"])
  end

  # Cldr::Data.locales.each do |locale|
  #   define_method "test: extract timezones for #{locale}" do
  #     assert_nothing_raised do
  #       Cldr::Data::Timezones.new(locale)
  #     end
  #   end
  # end
end






