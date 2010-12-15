class EventsListPresenter
  def initialize(events, current_user)
    @rows = events.map {|event| EventListRow.new(event, current_user)}
    @rows.each_cons(2) {|pair| pair[1].previous_row = pair[0]}
  end

  attr_reader :rows
end

class EventListRow
  def initialize(event, current_user)
    @event, @current_user = event, current_user
  end

  attr_reader :event
  attr_accessor :previous_row

  def date
    self.event.date.to_date
  end

  def show_date?
    return true if first_row?
    previous_row.date != self.date
  end

  def attending_or_tracking_friends
    self.event.attendees_followed_by(@current_user)
  end

  def attending_or_tracking_friends_info
    number_of_attending_friends = self.attending_or_tracking_friends.size
    return '' if number_of_attending_friends == 0
    number_of_people = pluralize(number_of_attending_friends, 'person')
    verb_to_use = pluralize(number_of_attending_friends, 'is', 'are').gsub(/\d+ /,'')
    "#{number_of_people} you are following #{verb_to_use} attending or tracking"
  end

  private
  def first_row?
    previous_row.nil?
  end

  def pluralize(count, singular, plural=singular.pluralize)
    return '1 ' + singular if count == 1
    count.to_s + ' ' + plural
  end
end
