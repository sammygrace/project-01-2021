import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("disconnected");
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("receiving ...");
    console.log("MESSAGE: " + data.content);

    $('#msg').append('<strong>' + data.user_id + '</strong>');
    $('#msg').append('<div>' + data.content + '</div>');
    $('#msg').append('<div style="text-align:right">' + data.created_at + " ago" + '</div>');
  }
});
