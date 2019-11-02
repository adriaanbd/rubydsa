def is_vowel?(letter)
  vowels = {'a' => 1, 'e' => 1, 'i' => 1, 'o' => 1, 'u' => 1}
  return vowels.fetch(letter, 0)
end

def count_vowels(str, idx)
  return is_vowel?(str[idx - 1]) if idx == 1
  return count_vowels(str, idx - 1) + is_vowel?(str[idx - 1])
end

s = 'hello'
p count_vowels(s, s.size) == 2