def reverse_str(str)
  return str if str.size.zero?
  reverse_str(str[1, str.size]) << str[0]
end

p (reverse_str('hello') == 'olleh')