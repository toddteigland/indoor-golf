# Clear existing data (if desired)
# Round.destroy_all

# Find or create rounds with the initial placeholder courses
["Fairmont Chateau Whistler GC", "TBD Course 2", "TBD Course 3", "TBD Course 4", "TBD Course 5", "TBD Course 6"].each_with_index do |course_name, index|
  # Find the round by its unique round_number
  round = Round.find_or_initialize_by(round_number: index + 1)

  # Update the course name only if it matches a placeholder or needs correction
  case round.round_number
  when 2
    round.course = "Georgia Golf Club"
  when 3
    round.course = "Gold Mountain Olympic"
  else
    round.course = course_name if round.course.blank? || round.course.start_with?("TBD")
  end

  round.save! # Save changes or create new record
end

