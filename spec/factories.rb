require 'factory_girl'
require 'spec_helper'

Factory.define :user do |u|
  u.sequence(:username){|n| "current_user#{n}"}
  u.sequence(:email) {|n| "current_user#{n}@email.it"}
  u.password "apassword"
  u.password_confirmation "apassword"
  u.country "United Kingdom"
  u.city "London"
  u.full_name "current user"
  u.agreed_tc_and_pp true
  u.active true
end

Factory.define :david, :parent => :user do |u|
  u.sequence(:username){|n| "david#{n}"}
  u.full_name "David Santoro"
end

Factory.define :stranger, :parent => :user do |u|
  u.sequence(:username){|n| "strangeson#{n}"}
  u.full_name "Stranger Strangeson"
end

Factory.define :ken, :parent => :user do |u|
  u.sequence(:username){|n| "ken#{n}"}
  u.full_name "Ken Alex Fassone"
end

Factory.define :group do |g|
  g.name "London Developers"
  g.unique_name "london-developers"
  g.organizer {|organizer| organizer.association(:user) }
  g.description "A description"
  g.active true
end

Factory.define :event do |e|
  e.description "A description"
  e.date Time.now.utc
  e.country "United Kingdom"
  e.city "London"
  e.attendees []
  e.trackers []
end

Factory.define :event_with_group, :parent => :event do |u|
  u.group { |group| group.association(:group) }
end

Factory.define :attendance do |a|
  a.user {|user| user.association(:user)}
  a.event { |event| event.association(:event)}
end

Factory.define :membership do |m|
  m.id 18
  m.user {|user| user.association(:user)} 
  m.group {|group| group.association(:group)} 
end

Factory.define :user_activity do |ua|
  ua.activity UserIsAttendingAnEvent.new(Factory(:event))
  ua.friend {|friend| friend.association(:ken)}
  ua.date Time.now.utc
end

Factory.define :link do |l|
  l.url 'http://arandomlink.rnd'
  l.title 'Link Title'
  l.description "Link description"
end

Factory.define :a_link, :parent => :link do |l|
  l.url 'http://www.google.com'
  l.title 'Google Search Engine'
  l.description "I'm the best search engine in the world"
  l.id 343
end

Factory.define :another_link, :parent => :link do |l|
  l.url 'http://www.yahoo.com'
  l.title 'Yahoo Search Engine'
  l.description "I'm the other best search engine in the world"
  l.id 245
end

Factory.define :code_snippet do |cs|
  cs.code 'Lots of code.... in some language'
  cs.language 'rb'
  cs.title 'Code snippet Title'
  cs.description "A code snippet description"
  cs.author {|user| user.association(:user)}
end

Factory.define :a_code_snippet, :parent => :code_snippet do |cs|
  cs.code 'Some code'
  cs.language 'py'
  cs.title 'Code I want to share'
  cs.description "A new script I wrote"
  cs.id 343
end

Factory.define :another_code_snippet, :parent => :code_snippet do |cs|
  cs.code 'Some crappy code'
  cs.language 'csharp'
  cs.title 'Code I found at work'
  cs.description "This is really shitty code"
  cs.id 245
end

