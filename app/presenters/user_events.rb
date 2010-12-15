class UserEvents
  def initialize(opts)
    @events = opts[:events]
    @location = opts[:location]
  end

  attr_reader :events, :location

  def empty?
    @events.empty?
  end
end
