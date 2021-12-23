# frozen_string_literal: true

module Fix
  def self.name(name)
    name = name.delete_suffix(' [C]') # Remove contractor notation
    name = name.gsub(/\s+/, ' ').strip # normalize spaces
    name = hungarian(name)
    /\A(?<first>\S+)\s+(?<last>.*)\z/.match(name)
  end

  def self.location(location)
    /\A(?<country>[^-]+)-.*\z/.match(location)
  end

  def self.hungarian(name)
    name = 'Tamas Gombos' if name == 'Gombos Tamas'
    name = 'Liliana Kadar' if name == 'Kadar Liliana'
    name = 'Miklos Kertesz' if name == 'Kertesz Miklos'
    name = 'Matyas Lillin' if name == 'Lillin Matyas'
    name = 'Dóra Marsal' if name == 'Marsal Dóra'
    name = 'Dóra Tóth-Major' if name == 'Tóth-Major Dóra'
    name = 'Ildiko Feher' if name == 'Feher Ildiko'
    name
  end
end
