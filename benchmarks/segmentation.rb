# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'benchmark/ips'
require 'json'
require 'twitter_cldr'

-> {
  str = "I really like Ms. Murphy. She's so, so cool! I wish she could come every day."

  puts '############## SEGMENTATION ##############'

  Benchmark.ips do |x|
    iterator = TwitterCldr::Segmentation::BreakIterator.new(:en, {
      use_uli_exceptions: true
    })

    x.config(warmup: 2)

    x.report 'Segmentation by sentence (without ULI rules)' do
      iterator.each_sentence(str).to_a
    end

    previous_benchmark = TwitterCldr::Utils.deep_symbolize_keys(
      JSON.parse(
        File.read('benchmarks/results/segmentation_without_uli.json')
      )
    )

    current_benchmark = x.full_report.data

    "#{current_benchmark[:ips]} <=> #{previous_benchmark[:ips]}"
  end

  # Benchmark.ips do |x|
  #   iterator = TwitterCldr::Segmentation::BreakIterator.new(:en, {
  #     use_uli_exceptions: false
  #   })

  #   x.config(warmup: 2)
  #   x.json!('benchmarks/results/segmentation_with_uli.json')

  #   x.report 'Segmentation by sentence (with ULI rules)' do
  #     iterator.each_sentence(str).to_a
  #   end
  # end
}.call
