require 'teedler/sentence.rb'
require 'teedler/normal_function.rb'
require 'matrix'
require 'pry'

class Teedler
  def initialize(text)
    @sentences = Sentence.new_group text
    @n = @sentences.length
    @word_counts = @sentences.map { |s| s.count_words }
    @base_hash = @word_counts.map { |s| s.keys }.flatten.each_with_object(0).to_h
  end

  def summarize
    binding.pry
    #distribution = NormalFunction.new(means, sigma2s)

    #sentences.max_by.with_index do |sentence, i|
    #  distribution.probability word_counts[i]
    #end.gsub(/\s?\n\s?/, '')
  end

  private

  def means
    mean_arr = @word_counts.reduce({}) do |h, count|
      h.merge(count) { |k, a, b| a + b }
    end.values.map { |x| x.to_f/@n }
    Vector.elements mean_arr
  end
  
  def vectorize_counts(count)
    Vector.elements @base_hash.merge(count).values
  end

  def sigma
    @word_counts.reduce(Matrix.zero(@base_hash.length)) do |m, count|
      v = vectorize_counts(count) - means
      m + v * v.covector
    end / @n
  end

end
