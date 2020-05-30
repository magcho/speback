import consumer from "./consumer";

let connection;

if (!connection) {
  document.addEventListener(
    "turbolinks:load",
    () => {
      const uri = location.href;

      if (/slides\/\d+\/pages\/\d+/.test(uri)) {
        const slideId = uri.match(/slides\/(\d+)/)[1];
        connection = consumer.subscriptions.create(
          { channel: "PresentationChannel", slide_id: slideId },
          {
            connected() {
              console.log("connected");
            },

            disconnected() {
              console.log("disconnected");
            },

            received(data) {
              const commentsArea = document.getElementById("comments");
              const newComments = `<div class="comment"><a target="_blank" href="https://twitter.com/twitter/status/${data.tweet_id}"><div class="comment-icon" style="background-image: url(${data.icon_url});"></div></a><p class="comment-text"><span class="comment-time">${data.created_at}</span>${data.text}</p></div>`;
              commentsArea.insertAdjacentHTML("beforeend", newComments);
            }
          }
        );
      }
    },
    {
      once: true
    }
  );
}
