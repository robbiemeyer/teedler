class Sentence < String

  def self.new_group (input)
    paragraph = self.new input
    paragraph.split /(?<=[?.!])\s*/
  end

end
