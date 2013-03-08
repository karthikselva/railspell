module RSpell

  def self.aspell 
    speller = Aspell.new("en_US")
    speller.suggestion_mode = Aspell::NORMAL
    speller.set_option("ignore-case", ignore_case.to_s)
  end 

  def self.check(word,ignore_case=true)
    aspell.check word 
  end 

  def self.suggest(word,ignore_case=true)
    aspell.suggest word 
  end 

end
