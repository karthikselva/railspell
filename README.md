railspell
=========

aspell based dictionary binding for Rails

Install:
======== 

    rails g railspell:install
    rake db:migrate 

Usage
=====
- Load the library 

>     require 'rubygems'
>     require 'railspell'

- Create your own dictionary

>     RailsDictionary.create :name => "MyOwnDictionary" , [:language => "en" , :number_of_words => 5]
    
- Lets start playing activate your dictionary

>     RailsDictionary.activate("MyOwnDictionary") 
>     RSpell.check "vertizon"  => false

- Add your own words in your dictionary 

>     RailsDictionary.add_words ["MyRulesMyWorld","Unpossible","Babystander","vertizon"] 
    
- Check whether it works 

>     RSpell.check "vertizon"  => true

- Add some more words

>     RailsDictionary.remove_word "Unpossible"
>     RailsDictionary.add_word "Thou'"

- Play time is over restore it back old state

>     RailsDictionary.deactivate("MyOwnDictionary") 


