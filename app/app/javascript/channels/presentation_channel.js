import consumer from "./consumer";

document.addEventListener("turbolinks:load", () => {
  consumer.subscriptions.create("PresentationChannel", {
    connected() {
      console.log("connected");
    },

    disconnected() {
      console.log("disconnected");
    },

    received(data) {
      console.log("recieved");
      console.log(data);

      const commentsArea = document.getElementById("comments");
      const newComments = `<div class="comment"><a target="_blank" href="https://twitter.com/twitter/status/${data.tweet_id}"><div class="comment-icon" style="background-image: url(${data.icon_url});"></div></a><p class="comment-text"><span class="comment-time">${data.created_at}</span>${data.text}</p></div>`;
      commentsArea.insertAdjacentHTML("beforeend", newComments);
    }
  });
});
