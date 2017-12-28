class Sentence < String

  def self.new_group (input)
    paragraph = self.new input
    paragraph.split /(?<=[?.!])(?=\W)\s*/
  end

  def count_words
    no_punctuation.split(' ').group_by { |word| word.downcase }.transform_values(&:count)
  end

  def no_punctuation
    self[/.*[^.!?]/] || ''
  end

end
