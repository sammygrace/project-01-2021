import consumer from "./consumer"

var roomName = document.querySelector("h1");

consumer.subscriptions.create({channel: "RoomChannel", room: roomName}, {
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
    console.log("ROOM: " + roomName);

    this.appendLine(data);
  },

  appendLine(data) {
    const html = this.createLine(data);
    const element = document.getElementById("new-msg");
    element.insertAdjacentHTML("beforeend", html);
  },

  createLine(data) {
    var user = document.getElementById(10);

    return `
      <p>
        <strong>
          ${data.user_id}
        </strong>

        <div>${data.content}</div>
        <div style="text-align:right"> 
          ${data.created_at}
        </div>
      </p>
    `
  },

});
