import consumer from "./consumer"

var cableData = document.getElementById('cabledata');
var senderId = cableData.dataset.userId;
var receiverId = cableData.dataset.adminUserId

consumer.subscriptions.create({ channel: "ChatChannel",
                                receiver_id: receiverId,
                                receiver_type: 'admin',
                                sender_id: senderId,
                                sender_type: 'user' }, {
  connected() {
    console.log()
  },

  disconnected() {
  },

  received(data) {
    console.log(data);
    var tableBody = document.querySelector("#table-container tbody");
    var newRow = document.createElement("tr");
    newRow.innerHTML = `
      <td>${data[1]}</td>
      <td>${data[0].message}</td>
    `;
    tableBody.appendChild(newRow);
  },
});