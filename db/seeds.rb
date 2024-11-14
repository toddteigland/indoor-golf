# Clear existing data (if desired)
# Round.destroy_all


# Find or create rounds with the initial placeholder courses
["Fairmont Chateau Whistler GC", "TBD Course 2", "TBD Course 3", "TBD Course 4", "TBD Course 5", "TBD Course 6"].each_with_index do |course_name, index|
  round = Round.find_or_create_by!(round_number: index + 1, course: course_name)

  # Update any placeholder course names to actual course names as needed
  if round.course == "TBD Course 2"
    round.update(course: "Georgia Golf Club")
  end
end
