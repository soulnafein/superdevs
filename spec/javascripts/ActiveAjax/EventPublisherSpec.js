describe("Event publisher", function() {
  it("should create a method to trigger the event", function() {
    var eventPublisher = ActiveAjax.EventPublisher();
    eventPublisher.canFire("nameChanged");

    expect(eventPublisher.onNameChanged).toBeDefined(Function);
  });

  it("should call registered actions when triggering", function() {
    var eventPublisher = ActiveAjax.EventPublisher();
    eventPublisher.canFire("numberChanged");

    var times = 0;
    eventPublisher.onNumberChanged(function(newValue) {times = times+1+newValue});
    eventPublisher.onNumberChanged(function(newValue) {times = times+5+newValue});

    eventPublisher.fire("numberChanged", 2);

    expect(times).toEqual(10);
  });
});