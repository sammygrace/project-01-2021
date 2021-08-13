import consumer from "./consumer.js";

consumer.subscriptions.create("PostChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to PostChannel!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("Disconnected from PostChannel");
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("updating posts feed ... ");

    this.appendLine(data);
  },

  appendLine(data) {
    const html = this.createPost(data);
    var table = document.querySelector("table");
    var newRow = table.insertRow();
    newRow.insertAdjacentHTML("beforeend", html);

    var posts = document.querySelector("div#posts");
    var newPost = table.querySelector("tr#new-post");
    table.insertAdjacentElement("afterBegin", newRow);

    var notice = document.querySelector("p#notice");
    notice.textContent = "Someone posted something new!";
  },

  createPost(data) {
    return `
    <tr>
      <td>
        <a href="/users/${data.user_id}/posts/${data.id}">${data.title}</a>
      </td>
      <td>${data.likes}</td>
      <td class="text-preview">${data.content}</td>
      <td>just now</td>
      <td><a href="/users/${data.user_id}">${data.user_name}</a></td>
    </tr>
    `
  },
});
