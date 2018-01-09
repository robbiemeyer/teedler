require 'teedler/sentence.rb'
require 'teedler/normal_function.rb'
require 'matrix'

class Teedler
  def initialize(text)
    @sentences = Sentence.new_group text
    @n = @sentences.length
    @word_counts = @sentences.map { |s| s.count_words }
  end

  def summarize
    distribution = NormalFunction.new(vectorize(means), sigma)

    probs = @sentences.map.with_index do |s, i| 
      distribution.probability(vectorize(@word_counts[i]))
    end

    @sentences.select.with_index do |sentence, i|
      probs.max - probs[i] <= 0.001
    end.join(' ').gsub(/\s?\n\s?/, '')
  end

  private

  def means
    @means ||= @word_counts.reduce({}) do |h, count|
      h.merge(count) { |k, a, b| a + b }
    end.transform_values { |x| x.to_r/@n }
  end

  def num_features
    if @n/2 + 1 > 15
      15
    else
      @n/2 + 1
    end
  end

  def features
    @features ||= means.max_by(num_features) { |k,v| v }.to_h.keys
  end
  
  def vectorize(hash)
    Vector.elements hash.fetch_values(*features) {0}
  end

  def sigma
    @word_counts.reduce(Matrix.zero(features.length)) do |m, count|
      v = vectorize(count) - vectorize(means)
      m + v * v.covector
    end / @n
  end

end
