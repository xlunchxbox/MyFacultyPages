# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

summary = 'Hello there! My name is John Doe and I am a professor of computer science here at the University of Astalia! It gives me great pleasure 
to welcome you to the computer science department.'

biography = 'I obtained my Ph.D. from the University of Houston in 2000 and have been teaching here ever since then as a professor.  My specialties lie'

FacultyMember.create(first_name: 'John', last_name: 'Doe', position: 'Professor', password: 'foobar', phone: 1234567890,
  password_confirmation: 'foobar', department: 'Computer Science', university_id: 123456, email: 'johndoe@uastalia.edu',
  summary: summary, biography: biography)

FacultyMember.create(first_name: 'Selvin', last_name: 'Doe', position: 'Professor', password: 'foobar', phone: 2345678901,
  password_confirmation: 'foobar', department: 'Computer Science', university_id: 234567, email: 'selvindoe@uastalia.edu')

Course.create(dept_code: 'COSC', course_no: 1410, name: 'Introduction to C++', term: 'Fall', year: 2013,
  summary: 'Introduction to the C++ programming language.', faculty_member_id: 1)

Course.create(dept_code: 'COSC', course_no: 1320, name: 'Introduction to Java', term: 'Spring', year: 2014,
  summary: 'Introduction to the Java programming language.', faculty_member_id: 1)

Course.create(dept_code: 'COSC', course_no: 2410, name: 'Logic and Design Fundamentals', term: 'Fall', year: 2014,
  summary: 'Logical operations within computer hardware and simplification of circuits.', faculty_member_id: 1)

Course.create(dept_code: 'COSC', course_no: 3310, name: 'Software Engineering', term: 'Spring', year: 2015,
  summary: 'Fundamental practices for developing software to industry standards.', faculty_member_id: 1)

Research.create(topic: 'Fundamentals of Artificial Intelligence and its Applications', start_date: Date.new(2007, 6, 1),
	end_date: Date.today, summary: 'Sample summary for reserach topic goes here.', faculty_member_id: 1)

Research.create(topic: 'Computing Networks', start_date: Date.new(1995, 5, 1), faculty_member_id: 1,
  end_date: Date.today, summary: 'Another ample summary for reserach topic goes here.')

Research.create(topic: 'Medical Imaging and Robotics', start_date: Date.new(1997, 8, 1), faculty_member_id: 1,
	end_date: Date.today, summary: 'Yet another sample summary for reserach topic goes here.')

Publication.create(title: 'Introduction to C++ Programming', year: 2000, faculty_member_id: 1,
	summary: 'A great textbook for introductory computer science students being introduced to C++.')

Publication.create(title: 'Introduction to Java Programming', year: 2000, faculty_member_id: 1,
	summary: 'A great textbook for introductory computer science students being introduced to Java.')

Degree.create(title: 'Ph.D', field_of_study: 'Computer Science', institution: 'University of Astalia',
	issue_date: Date.new(2003, 6, 1), faculty_member_id: 1)

Award.create(title: 'Best Teaching Award', issuer: 'University of Astalia', issue_date: Date.new(2008, 2, 1),
  summary: 'Awarded for recognition of teaching efforts here at UACS.', faculty_member_id: 1)

Employment.create(company: 'Foo Company', position: 'Software Developer', start_date: Date.new(2003, 1, 2),
  end_date: Date.new(2005, 5, 2), summary: 'Worked as a software developer for the advertising department',
  faculty_member_id: 1)
