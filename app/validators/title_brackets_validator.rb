class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    title = record.title
    stack = []
    char_position = 0
    lookup = { "(" => ")", "[" => "]", "{" => "}" }
    left   = lookup.keys
    right  = lookup.values

    title.each_char.with_index(1) do |char, i|
      if left.include? char
        stack << char
        char_position = i
      elsif right.include? char
        record.errors.add(:title, "This record is invalid") if stack.empty? || ((char_position + 1) == i) || (lookup[stack.pop] != char)
      end
    end

    record.errors.add(:title, "This record is invalid") if stack.length.odd?
    return true if stack.empty?
  end
end
