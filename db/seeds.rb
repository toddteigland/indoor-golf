# Find or create rounds with the initial placeholder courses
["Fairmont Chateau Whistler GC", "TBD Course 2", "TBD Course 3", "TBD Course 4", "TBD Course 5", "TBD Course 6"].each_with_index do |course_name, index|
  round = Round.find_or_initialize_by(round_number: index + 1)

  new_course_name = case round.round_number
  when 2 then "Georgia Golf Club"
  when 3 then "Gold Mountain Olympic"
  when 4 then "Bear Mountain"
  when 5 then "Wolf Creek Golf Club"
  else course_name
  end
  
  # Only update if the course name has changed
  if round.course != new_course_name
    round.update!(course: new_course_name)
  end

end