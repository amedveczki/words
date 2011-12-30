require 'rubygems'
require 'data_mapper' # requires all the gems listed above

DataMapper::Logger.new($stdout, :debug)

# An in-memory Sqlite3 connection:
# DataMapper.setup(:default, 'sqlite::memory:')

# # A Sqlite3 connection to a persistent database
dbdir = File.expand_path(File.dirname(__FILE__))
DataMapper.setup(:default, "sqlite://#{dbdir}/szavak.sqlite")

class Book
  include DataMapper::Resource

  property :id, Serial
  property :title, String, :required => true
  property :author, String, :required => true

  has n, :sentences
end

class Sentence
  include DataMapper::Resource

  property :id, Serial
  property :text, String
  belongs_to :book

  has n, :words, :through => Resource
end

class Word
  include DataMapper::Resource

  property :id, Serial
  property :known, Boolean, :default => false

  has n, :word_forms
  has n, :sentences, :through => Resource
end

class WordForm
  include DataMapper::Resource

  property :form, String, :key => true

  belongs_to :word
end

DataMapper.finalize
DataMapper.auto_upgrade!

# b = Book.new(:title => "tesztkonyv")
# 
# s1 = Sentence.new(:text => "Hello world!")
# s1.book = b
# 
# whello = Word.new(:word => "Hello")
# wworld = Word.new(:word => "world")
# 
# s1.words << whello << wworld
# 
# s2 = Sentence.new(:text => "Hello Adam!", :book => b)
# wadam = Word.new(:word => "Adam")
# s2.words << whello
# s2.words << wadam
# 
# b.save
# s1.save
# s2.save
# 
# Sentence.all(:sentence_words => {:word_id => Word.first(:fields => [:id], :word => "Hello").id})

# wid = Word.first(:word => "Hello")
# Sentence.all(:words => { :id => wid })
# Sentence.all(:words => { :word => "Hello" })                  
# raise rescue puts $!.backtrace
# nem DM-core
# nem do adapter



