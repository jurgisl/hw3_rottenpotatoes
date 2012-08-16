# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|

    a = Movie.new(
	:title => movie[:title],
	:rating => movie[:rating],
	:release_date => movie[:release_date]
	)

    a.save    
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
#  flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(",").each do |rating|
     step "I #{uncheck}check \"ratings_#{rating}\""
  end
end

Then /I should (not )?see movies with ratings: (.*)/ do |unmatch,ratings_list|
  Movie.find_all_by_rating(ratings_list.split(",")).each do |movie|
     step "I should #{unmatch}see \""+movie[:title]+"\""
  end
end

Then /I should see (\d+) movies/ do |num|
  num = num.to_i
  rows = page.find('#movies').all('tr').count - 1
  assert rows == num, "Movies count #{rows} is not #{num}"
end

Then /I should see all of the movies/ do
  count = Movie.count
  step "I should see #{count} movies"
end
