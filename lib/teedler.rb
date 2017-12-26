require './lib/teedler/sentence.rb'

class Teedler
  class << self

    def summarize(text)
      sentences = Sentence.new_group text
      word_counts = sentences.map { |s| s.count_words }

      word_totals = word_counts.reduce({}) do |totals, count|
        totals.merge(count) { |k, a, b| a + b }
      end

      n = sentences.length
      means = word_totals.transform_values { |x| x.to_f/n }

    end

  end
end
