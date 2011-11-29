# encoding: utf-8

require File.dirname(__FILE__) + '/../test_helper.rb'

class TestCldrDataTerritories < Test::Unit::TestCase
  define_method 'test: territories :de' do
    codes = [:"001", :"002", :"003", :"005", :"009", :"011", :"013", :"014",
             :"015", :"017", :"018", :"019", :"021", :"029", :"030", :"034",
             :"035", :"039", :"053", :"054", :"057", :"061", :"062", :"142",
             :"143", :"145", :"150", :"151", :"154", :"155", :"172", :"419",
             :"830", :AD, :AE, :AF, :AG, :AI, :AL, :AM, :AN, :AO, :AQ, :AR,
             :AS, :AT, :AU, :AW, :AX, :AZ, :BA, :BB, :BD, :BE, :BF, :BG, :BH,
             :BI, :BJ, :BL, :BM, :BN, :BO, :BR, :BS, :BT, :BV, :BW, :BY, :BZ,
             :CA, :CC, :CD, :CF, :CG, :CH, :CI, :CK, :CL, :CM, :CN, :CO, :CR,
             :CS, :CU, :CV, :CX, :CY, :CZ, :DE, :DJ, :DK, :DM, :DO, :DZ, :EC,
             :EE, :EG, :EH, :ER, :ES, :ET, :FI, :FJ, :FK, :FM, :FO, :FR, :GA,
             :GB, :GD, :GE, :GF, :GG, :GH, :GI, :GL, :GM, :GN, :GP, :GQ, :GR,
             :GS, :GT, :GU, :GW, :GY, :HK, :HM, :HN, :HR, :HT, :HU, :ID, :IE,
             :IL, :IM, :IN, :IO, :IQ, :IR, :IS, :IT, :JE, :JM, :JO, :JP, :KE,
             :KG, :KH, :KI, :KM, :KN, :KP, :KR, :KW, :KY, :KZ, :LA, :LB, :LC,
             :LI, :LK, :LR, :LS, :LT, :LU, :LV, :LY, :MA, :MC, :MD, :ME, :MF,
             :MG, :MH, :MK, :ML, :MM, :MN, :MO, :MP, :MQ, :MR, :MS, :MT, :MU,
             :MV, :MW, :MX, :MY, :MZ, :NA, :NC, :NE, :NF, :NG, :NI, :NL, :NO,
             :NP, :NR, :NU, :NZ, :OM, :PA, :PE, :PF, :PG, :PH, :PK, :PL, :PM,
             :PN, :PR, :PS, :PT, :PW, :PY, :QA, :QO, :QU, :RE, :RO, :RS, :RU,
             :RW, :SA, :SB, :SC, :SD, :SE, :SG, :SH, :SI, :SJ, :SK, :SL, :SM,
             :SN, :SO, :SR, :ST, :SV, :SY, :SZ, :TC, :TD, :TF, :TG, :TH, :TJ,
             :TK, :TL, :TM, :TN, :TO, :TR, :TT, :TV, :TW, :TZ, :UA, :UG, :UM,
             :US, :UY, :UZ, :VA, :VC, :VE, :VG, :VI, :VN, :VU, :WF, :WS, :YE,
             :YT, :ZA, :ZM, :ZW, :ZZ]

    territories = Cldr::Data::Territories.new(:de)[:territories]
    assert (territories.keys - codes).empty? && (codes - territories.keys).empty?
    assert_equal('Deutschland', territories[:DE])
  end

  # Cldr::Data.locales.each do |locale|
  #   define_method "test: extract territories for #{locale}" do
  #     assert_nothing_raised do
  #       Cldr::Data::Territories.new(locale)
  #     end
  #   end
  # end
end







