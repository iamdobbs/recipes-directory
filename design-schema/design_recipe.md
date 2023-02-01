# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

** Please view _recipie\_directory\_design\_schema\.md_ for more details **

Table: recipes

Columns:
name | avg_cook_time | rating
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_recipe.sql)

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

INSERT INTO recipes (name, avg_cook_time, rating) VALUES ('Stuffed Sweet Potatoes', '30', '5');
INSERT INTO recipes (name, avg_cook_time, rating) VALUES ('Noodles', '5', '4');
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: recipes

# Model class
# (in lib/recipe.rb)
class Recipe
end

# Repository class
# (in lib/recipe_repository.rb)
class RecipeRepository
end
```

## 4. Implement the Model class

```ruby
# Table name: recipes

# Model class
# (in lib/recipe.rb)

class Recipe
  attr_accessor :id, :name, :avg_cook_time, :rating
end
```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: recipes

# Repository class
# (in lib/recipe_repository.rb)

class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, avg_cook_time, rating FROM recipes;

    # Returns an array of Recipe objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, avg_cook_time, rating FROM recipes WHERE id = $1;

    # Returns a single Recipe object.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all recipes

repo = RecipeRepository.new

recipes = repo.all

recipes.length # =>  2
recipes.first.id # =>  1
recipes.first.name # =>  'Stuffed Sweet Potatoes  '
recipes.first.avg_cook_time # => '30'
recipes.first.rating # =>  '5'

# 2
# Gets Noodles recipe

repo = RecipeRepository.new

recipe = repo.find(2)

recipe.id # =>  2
recipe.name # =>  'Noodles'
recipe.avg_cook_time # =>  '5'
recipe.rating # => '4'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby

# file: spec/recipe_repository_spec.rb

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipe.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  # tests will go here

end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
