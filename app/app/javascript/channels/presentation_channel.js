import consumer from "./consumer";

var connectedSlideId;
var currentPresenterPageNum;

document.addEventListener("turbolinks:load", () => {
  const uri = location.href;
  if (/slides\/\d+\/pages\/\d+/.test(uri)) {
    const slideId = uri.match(/slides\/(\d+)/)[1];

    if (slideId == connectedSlideId) {
      // already connected
      return false;
    } else {
      connectedSlideId = slideId;
    }

    consumer.subscriptions.create(
      { channel: "PresentationChannel", slide_id: slideId },
      {
        connected() {
          console.log("connected");
        },
        disconnected() {
          console.log("disconnected");
        },
        received(data) {
          if (data.mode == "comment") {
            // realtime show comments
            const commentsArea = document.getElementById("comments");
            const newComments = `<div class="comment"><a target="_blank" href="https://twitter.com/twitter/status/${data.tweet_id}"><div class="comment-icon" style="background-image: url(${data.icon_url});"></div></a><p class="comment-text"><span class="comment-time">${data.created_at}</span>${data.text}</p></div>`;
            commentsArea.insertAdjacentHTML("beforeend", newComments);
          } else if (data.mode == "page") {
            // auto pageing
            currentPresenterPageNum = data.page_num;
            Turbolinks.visit(
              `${location.protocol}//${location.host}/slides/${slideId}/pages/${data.page_num}`
            );
          }
        }
      }
    );
  }
});
