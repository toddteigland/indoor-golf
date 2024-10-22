# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Clear existing data (if desired)
Round.destroy_all

# Create new course records
Round.create([
  { round_number: 1, course: 'TBD Course 1' },
  { round_number: 2, course: 'TBD Course 2' },
  { round_number: 3, course: 'TBD Course 3' },
  { round_number: 4, course: 'TBD Course 4' },
  { round_number: 5, course: 'TBD Course 5' },
  { round_number: 6, course: 'TBD Course 6' }
])
