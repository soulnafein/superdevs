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

Factory.define :attendance do |a|
  a.user {|user| user.association(:user)}
  a.event { |event| event.association(:event)}
end

Factory.define :membership do |m|
  m.id 18
  m.user {|user| user.association(:user)} 
  m.group {|group| group.association(:group)} 
end

