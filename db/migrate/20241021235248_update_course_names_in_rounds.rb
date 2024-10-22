class UpdateCourseNamesInRounds < ActiveRecord::Migration[7.1]
  def up
    Round.where(course: [
      'Pebble Beach', 
      'St. Andrews', 
      'Augusta National', 
      'Pinehurst No. 2', 
      'Royal Melbourne', 
      'Cypress Point'
    ]).destroy_all
  end

  def down
    Round.create([
      { round_number: 1, course: 'Pebble Beach' },
      { round_number: 2, course: 'St. Andrews' },
      { round_number: 3, course: 'Augusta National' },
      { round_number: 4, course: 'Pinehurst No. 2' },
      { round_number: 5, course: 'Royal Melbourne' },
      { round_number: 6, course: 'Cypress Point' }
    ])
  end
end
