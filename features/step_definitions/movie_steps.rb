# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    #p movie[:title] 
    #p movie[:rating]
#    @m = Movie.create!(movie[:title], movie[:rating])
#    @m = Movie.create!(movie[:title])
    @m = Movie.create!(:title => movie[:title], :rating => movie[:rating], :Director => movie[:director], :release_date => movie[:release_date])
    #movie = Movie.new(:title => 'Title', :rating => 'PG-13')
  end
#  redirect_to movies_path
#  assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
#d1 = "Aladdin"
#  d2 = "Amelie"
  first_position = page.body.index(e1)
  second_position = page.body.index(e2)
  if first_position > second_position
    assert false, "Out of order"
  end

#  assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  #p rating_list
#debugger
  if uncheck
    rating_list.split(/, /).each do |rating|
       # p "ratings_"+rating
       uncheck("ratings_"+rating)
       #When I uncheck "#{rating}"
    end 
  else
    rating_list.split(/, /).each do |rating|
       #  p "ratings_"+rating
       check("ratings_"+rating)
        #  When I check "#{rating}"
    end 
  end

end

Then /I should see all of the movies/ do 
#if page.respond_to? :should
#  p "Hello world"
#  p Movie.all.count
#  p page.all("table tbody tr").length

   if Movie.all.count != page.all("table tbody tr").length
     assert false, "Incorrect"
   end

#  if page.respond_to? :should
#   #page.should have_selector('table tr', :count => Movie.all.count)
#    page.should have_selector('table tbody tr', :count => 10)
#  else
#    assert false, "Incorrect"
#  end
#if page.has_table?('movies', :count => 70)
#        p "Page has 10 rows"
#   end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  @movie = Movie.find_by_title(arg1)
  @director = @movie.Director
  if @director != arg2
    assert false, "Director info incorrect"
  end
end

