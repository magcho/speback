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

            // ユーザーによるページ操作のオーバーライドがあるならば強制遷移しない
            const slideEle = document.getElementById("slide");
            const currentPresenterPageNum = slideEle.getAttribute(
              "data-current-presenter-page-num"
            );
            const pageNum = slideEle.getAttribute("data-page-num");

            if (pageNum == currentPresenterPageNum) {
              // 強制遷移
              // currentPresenterPageNum = data.page_num;
              slideEle.setAttribute(
                "data-current-presenter-page-num",
                data.page_num
              );
              Turbolinks.visit(
                `${location.protocol}//${location.host}/slides/${slideId}/pages/${data.page_num}`
              );
            } else {
              slideEle.setAttribute(
                "data-current-presenter-page-num",
                data.page_num
              );
              setHrefBackButton(data.page_num);
            }
          }
        }
      }
    );
  }
});

function setHrefBackButton(targetPageNum) {
  const slideEle = document.getElementById("slide");
  const slideId = slideEle.getAttribute("data-slide-id");
  const target = `${location.protocol}//${location.host}/slides/${slideId}/pages/${targetPageNum}`;
  document.getElementById("backward-button-link").setAttribute("href", target);
  document.getElementById("forward-button-link").setAttribute("href", target);
}
