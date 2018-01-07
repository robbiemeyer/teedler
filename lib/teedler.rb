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

    @sentences.max_by(3).with_index do |sentence, i|
      distribution.probability vectorize(@word_counts[i])
    end.join(' ').gsub(/\s?\n\s?/, '')
  end

  private

  def means
    @means ||= @word_counts.reduce({}) do |h, count|
      h.merge(count) { |k, a, b| a + b }
    end.transform_values { |x| x.to_r/@n }
  end

  def features
    @features ||= means.max_by(@n/2 +1) { |k,v| v }.to_h.keys
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
