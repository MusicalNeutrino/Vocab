require_relative 'vocab_list'
require_relative 'vocab_word'

class FileVocabList < VocabList
  def initialize(file_name, delimiter)
    @file_name = file_name
    @delimiter = delimiter
  end

  def vocab_words
    IO.readlines(@file_name)
      .map { |line| line.split(@delimiter) }
      .map { |word_data|
      VocabWord.new(word_data[0].strip, word_data[1].strip, word_data[2].nil? ? '' : word_data[2].strip)
    }
  end

  def add_vocab_words(vocab_words)
    File.open(@file_name, 'a') { |file|
      vocab_words.each { |vocab_word|
        file.write("#{vocab_word.word} : #{vocab_word.definition} : #{vocab_word.example}")
      }
    }
  end
end