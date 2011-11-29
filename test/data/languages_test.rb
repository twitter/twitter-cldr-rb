# encoding: utf-8

require File.dirname(__FILE__) + '/../test_helper.rb'

class TestCldrDataLanguages < Test::Unit::TestCase
  define_method 'test: languages :de' do
    codes = [:aa, :ab, :ace, :ach, :ada, :ady, :ae, :af, :afa, :afh, :ain,
             :ak, :akk, :ale, :alg, :alt, :am, :an, :ang, :anp, :apa, :ar,
             :arc, :arn, :arp, :art, :arw, :as, :ast, :ath, :aus, :av, :awa,
             :ay, :az, :ba, :bad, :bai, :bal, :ban, :bas, :bat, :be, :bej,
             :bem, :ber, :bg, :bh, :bho, :bi, :bik, :bin, :bla, :bm, :bn, :bnt,
             :bo, :br, :bra, :bs, :btk, :bua, :bug, :byn, :ca, :cad, :cai,
             :car, :cau, :cch, :ce, :ceb, :cel, :ch, :chb, :chg, :chk, :chm,
             :chn, :cho, :chp, :chr, :chy, :cmc, :co, :cop, :cpe, :cpf, :cpp,
             :cr, :crh, :crp, :cs, :csb, :cu, :cus, :cv, :cy, :da, :dak, :dar,
             :day, :de, :"de-AT", :"de-CH", :del, :den, :dgr, :din, :doi, :dra,
             :dsb, :dua, :dum, :dv, :dyu, :dz, :ee, :efi, :egy, :eka, :el,
             :elx, :en, :"en-AU", :"en-CA", :"en-GB", :"en-US", :enm, :eo, :es,
             :"es-419", :"es-ES", :et, :eu, :ewo, :fa, :fan, :fat, :ff, :fi,
             :fil, :fiu, :fj, :fo, :fon, :fr, :"fr-CA", :"fr-CH", :frm, :fro,
             :frr, :frs, :fur, :fy, :ga, :gaa, :gay, :gba, :gd, :gem, :gez,
             :gil, :gl, :gmh, :gn, :goh, :gon, :gor, :got, :grb, :grc, :gsw,
             :gu, :gv, :gwi, :ha, :hai, :haw, :he, :hi, :hil, :him, :hit, :hmn,
             :ho, :hr, :hsb, :ht, :hu, :hup, :hy, :hz, :ia, :iba, :id, :ie,
             :ig, :ii, :ijo, :ik, :ilo, :inc, :ine, :inh, :io, :ira, :iro, :is,
             :it, :iu, :ja, :jbo, :jpr, :jrb, :jv, :ka, :kaa, :kab, :kac, :kaj,
             :kam, :kar, :kaw, :kbd, :kcg, :kfo, :kg, :kha, :khi, :kho, :ki,
             :kj, :kk, :kl, :km, :kmb, :kn, :ko, :kok, :kos, :kpe, :kr, :krc,
             :krl, :kro, :kru, :ks, :ku, :kum, :kut, :kv, :kw, :ky, :la, :lad,
             :lah, :lam, :lb, :lez, :lg, :li, :ln, :lo, :lol, :loz, :lt, :lu,
             :lua, :lui, :lun, :luo, :lus, :lv, :mad, :mag, :mai, :mak, :man,
             :map, :mas, :mdf, :mdr, :men, :mg, :mga, :mh, :mi, :mic, :min,
             :mis, :mk, :mkh, :ml, :mn, :mnc, :mni, :mno, :mo, :moh, :mos, :mr,
             :ms, :mt, :mul, :mun, :mus, :mwl, :mwr, :my, :myn, :myv, :na,
             :nah, :nai, :nap, :nb, :nd, :nds, :ne, :new, :ng, :nia, :nic,
             :niu, :nl, :"nl-BE", :nn, :no, :nog, :non, :nqo, :nr, :nso, :nub,
             :nv, :nwc, :ny, :nym, :nyn, :nyo, :nzi, :oc, :oj, :om, :or, :os,
             :osa, :ota, :oto, :pa, :paa, :pag, :pal, :pam, :pap, :pau, :peo,
             :phi, :phn, :pi, :pl, :pon, :pra, :pro, :ps, :pt, :"pt-BR",
             :"pt-PT", :qu, :raj, :rap, :rar, :rm, :rn, :ro, :roa, :rom, :root,
             :ru, :rup, :rw, :sa, :sad, :sah, :sai, :sal, :sam, :sas, :sat,
             :sc, :scn, :sco, :sd, :se, :sel, :sem, :sg, :sga, :sgn, :sh, :shn,
             :si, :sid, :sio, :sit, :sk, :sl, :sla, :sm, :sma, :smi, :smj,
             :smn, :sms, :sn, :snk, :so, :sog, :son, :sq, :sr, :srn, :srr, :ss,
             :ssa, :st, :su, :suk, :sus, :sux, :sv, :sw, :syc, :syr, :ta, :tai,
             :te, :tem, :ter, :tet, :tg, :th, :ti, :tig, :tiv, :tk, :tkl, :tl,
             :tlh, :tli, :tmh, :tn, :to, :tog, :tpi, :tr, :ts, :tsi, :tt, :tum,
             :tup, :tut, :tvl, :tw, :ty, :tyv, :udm, :ug, :uga, :uk, :umb,
             :und, :ur, :uz, :vai, :ve, :vi, :vo, :vot, :wa, :wak, :wal, :war,
             :was, :wen, :wo, :xal, :xh, :yao, :yap, :yi, :yo, :ypk, :za, :zap,
             :zbl, :zen, :zh, :"zh-Hans", :"zh-Hant", :znd, :zu, :zun, :zxx, :zza]
    
    languages = Cldr::Data::Languages.new('de')[:languages]
  
    assert (languages.keys - codes).empty? && (codes - languages.keys).empty?
    assert_equal('Deutsch', languages[:de])
  end
  
  # Cldr::Data.locales.each do |locale|
  #   define_method "test: extract languages for #{locale}" do
  #     assert_nothing_raised do
  #       Cldr::Data::Languages.new(locale)
  #     end
  #   end
  # end
end

