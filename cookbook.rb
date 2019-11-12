require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :recipes
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    loads_csv
  end

  def loads_csv
    # Read CSV and iterate through it
    CSV.foreach(@csv_file_path) do |row|
      # Convert to Recipe instance
      new_recipe = Recipe.new(row[0], row[1])
      # Push into recipes array
      @recipes << new_recipe
    end
  end

  def all
    # Returns array of Recipe instances
    @recipes
  end

  def add_recipe(recipe)
    # Append recipe to CSV
    CSV.open(@csv_file_path, 'a') do |csv|
      csv << [recipe.name, recipe.description]
    end
    # Add recipe instance to recipes array
    @recipes << recipe
  end

  def remove_recipe(recipe_index)
    # Remove recipe instance from recipes array
    @recipes.delete_at(recipe_index)
    # Wipe CSV file first?
    CSV.open(@csv_file_path, "w")
    # Rewrite CSV from Recipes array
    @recipes.each do |recipe|
      CSV.open(@csv_file_path, "a") do |csv|
        csv << [recipe.name, recipe.description]
      end
    end
  end
end


# cookbook_one = Cookbook.new("lib/recipes.csv")
# p cookbook_one.all

# recipe_one = Recipe.new("test_name", "test_description")
# recipe_two = Recipe.new("test_name2", "test_description2")

# cookbook_one.add_recipe(recipe_one)
# cookbook_one.add_recipe(recipe_two)

# p cookbook_one.all

# cookbook_one.remove_recipe(0)

# p cookbook_one.all
