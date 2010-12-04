beforeEach(function() {
  this.addMatchers({
    toBePlaying: function(expectedSong) {
      var player = this.actual;
      return player.currentlyPlayingSong === expectedSong
          && player.isPlaying;
    },
    toBeDefined: function() {
      return this.actual !== undefined;
    },
    toBeOneElementWithValueEqual: function(expectedValue) {
      var elem = this.actual;
      return elem.length === 1 && elem.val() === expectedValue;
    },
    toBeFocused: function() {
      var elem = this.actual[0];
      return elem === document.activeElement;
    }
  })
});
