module ApplicationHelper
  def semester
    terms = %w[Spring Summer Fall Winter\ Mini]
  end
  
  def years
    year = Time.now.year
    year.downto(1990).to_a
  end
end
