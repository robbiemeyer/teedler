require './lib/teedler/sentence.rb'

class Teedler
  class << self

    def summarize(text)
      sentences = Sentence.new_group text
      n = sentences.length
      word_counts = sentences.map { |s| s.count_words }

      means = word_counts.reduce({}) do |h, count|
        h.merge(count) { |k, a, b| a + b }
      end.transform_values { |x| x.to_f/n }

      sigma2s = word_counts.reduce({}) do |h, count|
        count.each do |k, v|
          h[k] = (h[k] || 0) + (v - means[k])**2
        end
        h
      end.transform_values { |x| x/n }
    end

  end
end
