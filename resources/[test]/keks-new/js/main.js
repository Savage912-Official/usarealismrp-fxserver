$(document).ready(function () {
    const LOADSCREEN_VIDEOS = [
      "img/loadscreen-video-1.mp4",
      "img/loadscreen-video-2.mp4",
    ]

    let chosenVideo = LOADSCREEN_VIDEOS[Math.floor(Math.random() * LOADSCREEN_VIDEOS.length)];
  
    $("video").attr("src", chosenVideo)
    $("video").play();
});
