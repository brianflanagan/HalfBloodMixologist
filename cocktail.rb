require 'active_support/inflector'
require './constants'

# TONGUE OF FROG MARTINI
# Pour a measure of ABSOLUT™ Vodka
# Add tongue of frog
# Stir thrice anti-clockwise
# Add hair of father
# Serve over ice

class Cocktail
  attr_accessor :name, :base_liquor, :liquor_brand, :ingredients, :steps, :serving_suggestion

  def initialize
    self.name = nil #str
    self.base_liquor = nil #sym
    self.liquor_brand = nil #str
    self.ingredients = [] #ary
    self.steps = [] #ary
    self.serving_suggestion = nil #str
  end

  def mix!
    # choose a base
    self.base_liquor = LIQUORS.sample
    self.liquor_brand = LIQUOR_BRANDS[self.base_liquor].sample

    # add ingredients
    1..2.times do
      self.ingredients << INGREDIENTS.sample
    end

    create_steps
    create_name
    create_serving_suggestion
  end

  def recipe
    (self.name.upcase + ':
- ' + self.steps.join('
- ') + '
' + self.serving_suggestion).strip
  end

  private

  def create_steps
    self.steps << if [true,false].sample
      "Pour a #{ ['measure','glug','shot'].sample } of #{ self.liquor_brand.upcase }™ #{ self.base_liquor.to_s.downcase }"
    else
      "Add a #{ ['measure','glug','shot'].sample } of #{ self.base_liquor.to_s.downcase }"
    end

    self.ingredients.uniq.each do |ingredient|
      self.steps << a_step_for_ingredient(ingredient)
      (self.steps << an_instruction_step) if [true,false,false].sample
    end
  end

  def create_name
    important_ingredient = self.ingredients.sample

    if [true,false,false].sample
      if important_ingredient.split(' ').size > 1
        self.name = "#{ important_ingredient } #{ LIQUOR_NAMES[self.base_liquor].sample }"
        return
      else
        self.name = "#{ self.base_liquor.to_s.capitalize } & #{ important_ingredient }"
        return
      end
    else
      potion_name = POTION_NAMES.sample
      if potion_name.include?('Potion')
        self.name = "#{ potion_name.gsub('Potion',LIQUOR_NAMES[self.base_liquor].sample) }"
      elsif potion_name.include?('Draught')
        self.name = "#{ potion_name.gsub('Draught',LIQUOR_NAMES[self.base_liquor].sample) }"
      else
        self.name = [potion_name,LIQUOR_NAMES[self.base_liquor].sample].shuffle.join(' ')
      end
    end
  end

  def an_instruction_step
    [
      ['Stir','Gently stir','Stir with vigour'].sample,
      [' once,',' twice,',' thrice,',' one time,',' two times,',' three times,',nil].sample,
      [' clockwise',' anti-clockwise'].sample
    ].compact.join('')
  end

  def a_step_for_ingredient(ingredient)
    "Add #{ an_amount } of #{ ingredient.downcase }"
  end

  def an_amount
    num = (1..3).to_a.sample
    "#{ number_to_word(num) } #{ pluralize(num, ['pinch','bundle','measure','scoop'].sample) }"
  end

  def pluralize(number, text)
    return text.pluralize if number != 1
    text
  end

  def number_to_word(number)
    {
      '1' => 'one',
      '2' => 'two',
      '3' => 'three',
      '4' => 'four'
    }[number.to_s]
  end

  def create_serving_suggestion
    self.serving_suggestion = [
      'Drink at the full moon',
      'Serve over ice',
      "Serve in a #{ ['pewter cauldron','tumbler','cauldron','brass cauldron','martini glass','gold cauldron','brass tumbler','pewter tumbler'].sample }",
      "Garnish with #{ [INGREDIENTS.sample,'lemon','lime',"blood of a #{ ['friend','enemy','father','mother','betrayor','rival','equal','better','servant'].sample }"].sample }"
    ].sample
  end
end