require_relative 'lib/database_connection'

DatabaseConnection.connect('recipes_directory_test')

sql = 'SELECT id, name, avg_cook_time, rating FROM recipes;'
result = DatabaseConnection.exec_params(sql, [])

result.each do |record|
  p "#{record['id']}. #{record['name']} - Cooking Time: #{record['avg_cook_time']} mins. Rating (1-5): #{record['rating']}"
end  