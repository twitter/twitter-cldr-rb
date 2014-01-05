# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'java'
require 'twitter_cldr/resources/download'

class IcuBasedImporter

  protected

  def require_icu4j(icu4j_path)
    TwitterCldr::Resources.download_icu4j_if_necessary(icu4j_path)
    require icu4j_path
  end

end
