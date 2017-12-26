class Sentence < String

  def self.new_group (input)
    paragraph = self.new input
    paragraph.split /(?<=[?.!])\s*/
  end

  def count_words
    split(' ').group_by { |word| word }.transform_values(&:count)
  end

end
