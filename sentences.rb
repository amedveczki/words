
def find_words(sentence)
  return sentence.scan(/\w+/).each { |x| x.downcase! }
end

def find_sentences(fname, max = 0)
  current = 0

  sentences = []

  $sentence_regex = /.*?[^.?!][.?!]([^.?!]|[\n\r])/m
  f = File.open fname

  if f
    # # print "Ok, #{fname} is now open.\n"
  else
    # # print "Could not open #{fname}!\n"
    return sentences
  end

  buff = f.gets
  while (max == 0 || max && current < max)
    buff.gsub!(/-?\n/, "-\n" => "", "\n" => " ")
    current += 1
    # print "Current: #{current}"
    # print "Trying to match regex #{$sentence_regex} to >>>>>#{buff}<<<<<\n"
    m = $sentence_regex.match(buff) 
    if m
      # print "MATCH: '#{m[0]}'\n"
      if not /\w/ =~ m[0]
        # No word inside, just filler. skip buffer
        buff = buff[m[0].size .. -1]
        # print "No word inside, skipping '#{m[0]}', filler, new buff: #{buff}\n"
        next
      end
    else
      # print "NO MATCH\n"
    end
    if not m or m[0].strip.size == 0 
      l = f.gets
      # print "f.gets: #{l}\n"
      if l == nil
        # print "l is nil, returning buf\n"
        return sentences
      end
      
      buff += l
    else
      s = m[0].strip()
      # print "S: '#{s}'\n"
      # print "Sentence: '#{s}' match was #{m[0]} will skip #{m[0].size} bytes\n"
      sentences.push(s)
      buff = buff[m[0].size .. -1]
      # print "S: #{s} (New buff: '#{buff}'\n)\n"
    end
  end
  return sentences
end

# txts = Dir.glob("*.txt")
# 
# $first = txts[0]
# 
$words = {}
$first = "teszt.txt"

sentences = find_sentences($first)
sentences.sort! {|b, a| a.length <=> b.length}

sentences.each { |elem| print "#{elem.length} #{elem}\n" }

puts "words in the first: " + find_words(sentences[0]).to_s
  # print "Sentence --> #{elem} <--\n"
  # find_words(elem).each do |word|
  #   if $words.has_key? word
  #     $words[word].push(elem)
  #   else
  #     $words[word] = [elem]
  #   end
  # end
# end
