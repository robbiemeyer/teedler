require 'teedler/sentence.rb'
require 'teedler/normal_function.rb'
require 'matrix'
require 'pry'

class Teedler
  def initialize(text)
    @sentences = Sentence.new_group text
    @n = @sentences.length
    @word_counts = @sentences.map { |s| s.count_words }
    @words = @word_counts.map { |s| s.keys }.flatten.uniq
  end

  def summarize
    sigma2s = word_counts.reduce({}) do |h, count|
      count.each do |k, v|
        h[k] = (h[k] || 0) + (v - means[k])**2
      end
      h
    end.transform_values { |x| x/n }

    distribution = NormalFunction.new(means, sigma2s)

    sentences.max_by.with_index do |sentence, i|
      distribution.probability word_counts[i]
    end.gsub(/\s?\n\s?/, '')
  end

  private

  def means
    meanarr = @word_counts.reduce({}) do |h, count|
      h.merge(count) { |k, a, b| a + b }
    end.values.map { |x| x.to_f/@n }
    Vector.elements meanarr
  end

end
