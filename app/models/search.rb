class Search < ActiveRecord::Base

	def movies
  @movies ||= find_movies
end

private

def find_movies
  Movie.find(:all, :conditions => conditions)
end

def keyword_conditions
  ["movies.title LIKE ?", "%#{keywords}%"] unless keywords.blank?
end

def under_90_condition
  ["movies.runtime_in_minutes >= ?", under_90] unless under_90.blank?
end

def between_90_120_condition
  ["products.price <= ?", between_90_120] unless between_90_120.blank?
end

def category_conditions
  ["movies.category_id = ?", category_id] unless category_id.blank?
end

def conditions
  [conditions_clauses.join(' AND '), *conditions_options]
end

def conditions_clauses
  conditions_parts.map { |condition| condition.first }
end

def conditions_options
  conditions_parts.map { |condition| condition[1..-1] }.flatten
end

def conditions_parts
  private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
end


end
