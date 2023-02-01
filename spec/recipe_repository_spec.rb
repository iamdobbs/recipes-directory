require 'recipe_repository'

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipe.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  it 'returns all recipes' do
    
    repo = RecipeRepository.new
    recipe = repo.all

    expect(recipe.length).to eq(2) 
    expect(recipe.first.id).to eq('1')
    expect(recipe.first.name).to eq('Stuffed Sweet Potatoes')
    expect(recipe.first.avg_cook_time).to eq('30')
    expect(recipe.first.rating).to eq('5')
  end

  it 'returns the second record, Noodles' do
    repo = RecipeRepository.new
    recipe = repo.find(2)

    expect(recipe.id).to eq('2')
    expect(recipe.name).to eq('Noodles')
    expect(recipe.avg_cook_time).to eq('5')
    expect(recipe.rating).to eq('4')
  end
end