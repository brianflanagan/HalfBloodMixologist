require './cocktail'

class CocktailGenerator
  def self.generate_cocktail
    cocktail = Cocktail.new
    cocktail.mix!
    return cocktail.recipe
  end
end