FactoryGirl.define do
  factory :faculty_member do |f|
    f.last_name      'SampleLast'
    f.first_name     'SampleFirst'
    f.position       'Professor'
    f.department     'Computer Science'
    f.summary        'Sample summary'
    f.biography      ''
    f.university_id  123456
    f.email          'Sample@example.com'
    f.phone          1234567890
    f.office         'PGH 123'
    f.password       'foobar'
    f.password_confirmation 'foobar'
  end

  factory :course do |c|
    c.dept_code      'COSC'
    c.course_no      1234
    c.name           'Introduction to Computer Science'
    c.term           'Fall'
    c.year           2013
    c.summary        'This course introduces students to computer science'
    c.association    :faculty_member
  end

  factory :research do |r|
    r.topic          'Sample Research Topic'
    r.start_date     Date.new(1997, 1, 1)
    r.end_date       Date.today
    r.summary        'This is a sample research summary.'
    r.association    :faculty_member
  end

  factory :publication do |p|
    p.title          'Sample Publication Title'
    p.summary        'This publication is a textbook that introduces students to foo'
    p.year           2000
    p.association    :faculty_member
  end

  factory :degree do |d|
    d.title          'Ph.D'
    d.field_of_study 'Computer Science'
    d.institution    'Foo University'
    d.issue_date     Date.today
    d.association    :faculty_member
  end

  factory :employment do |e|
    e.company        'Foo Company'
    e.position       'Foo developer'
    e.start_date     Date.new(2000, 1, 1)
    e.end_date       Date.today
    e.summary        'Worked as a foo developer for the company'
    e.association    :faculty_member
  end

  factory :award do |a|
    a.title          'Best Foo Award'
    a.issuer         'Foobar, Inc.'
    a.issue_date     Date.today
    a.summary        'Awarded for being best foo employee'
    a.association    :faculty_member
  end
end
