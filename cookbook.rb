require 'csv'
require_relative "recipe"

class Cookbook
  attr_reader :recipes

  # with CSV file:
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    # Each time a cookbook instance is created, the @recipes array is updated,
    # by creating a new intance of Recipe for each row of the CSV file - see below - by calling load_csv
    load_csv
  end

  # without CSV:
  # def initialize
  #   @recipes = []
  # end

  def all
    # returns all recipes
    @recipes
  end

  def find(id)
    @recipes[id]
  end

  def add_recipe(recipe)
    # add new recipe to cookbook
    @recipes << recipe
    # updates the CSV file
    write_csv
  end

  def remove_recipe(recipe_index)
    # deletes a recipe from cookbook
    @recipes.delete_at(recipe_index)
    # updates the CSV file
    write_csv
  end

  def load_csv
    # Each time a cookbook instance is created, the @recipes array is updated,
    # by creating a new intance of Recipe for each row of the CSV file
    CSV.foreach(@csv_file_path) do |row|
      done = row[3] == "true"
      @recipes << Recipe.new(row[0], row[1], row[2], done)
    end
  end

  def write_csv
    # Replaces and rewrites the whole contents of the CSV file
    # csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each { |elem| csv << [elem.name, elem.description, elem.prep_time, elem.status] }
    end
  end
end
