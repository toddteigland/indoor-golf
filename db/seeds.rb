# Clear existing data (if desired)
Round.destroy_all

# Find or create rounds with the initial placeholder courses
["Fairmont Chateau Whistler GC", "TBD Course 2", "TBD Course 3", "TBD Course 4", "TBD Course 5", "TBD Course 6"].each_with_index do |course_name, index|
  round = Round.find_or_create_by!(round_number: index + 1) # Match only on round_number

  # Update course names for specific rounds
  case round.round_number
  when 2
    round.update(course: "Georgia Golf Club")
  when 3
    round.update(course: "Gold Mountain Olympic")
  else
    round.update(course: course_name) # Set initial course names for other rounds
  end
end
