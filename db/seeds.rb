# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Rails.env.development?
  Comment.create!(author: "Kyle F.", text: "This is one comment")
  Comment.create!(author: "Oren M.", text: "This is *another* comment")
  Comment.create!(author: "JJ", text: "This is a *third* comment")
end
