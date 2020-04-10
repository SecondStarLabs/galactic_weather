// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("local-time").start();

window.Rails = Rails;

import "bootstrap";
import "data-confirm-modal";

$(document).on("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
});

// direct_uploads.js

addEventListener("direct-upload:initialize", (event) => {
  const { target, detail } = event;
  const { id, file } = detail;
  target.insertAdjacentHTML(
    "beforebegin",
    `
    <div id="direct-upload-${id}" class="direct-upload direct-upload--pending">
      <div id="direct-upload-progress-${id}" class="direct-upload__progress" style="width: 0%"></div>
      <span class="direct-upload__filename">${file.name}</span>
    </div>
  `
  );
});

addEventListener("direct-upload:start", (event) => {
  const { id } = event.detail;
  const element = document.getElementById(`direct-upload-${id}`);
  element.classList.remove("direct-upload--pending");
});

addEventListener("direct-upload:progress", (event) => {
  const { id, progress } = event.detail;
  const progressElement = document.getElementById(
    `direct-upload-progress-${id}`
  );
  progressElement.style.width = `${progress}%`;
});

addEventListener("direct-upload:error", (event) => {
  event.preventDefault();
  const { id, error } = event.detail;
  const element = document.getElementById(`direct-upload-${id}`);
  element.classList.add("direct-upload--error");
  element.setAttribute("title", error);
});

addEventListener("direct-upload:end", (event) => {
  const { id } = event.detail;
  const element = document.getElementById(`direct-upload-${id}`);
  element.classList.add("direct-upload--complete");
});

// stimulus
import "controllers";

// google places and maps
window.initMap = function(...args) {
  const event = document.createEvent("Events");
  event.initEvent("google-maps-callback", true, true);
  event.args = args;
  window.dispatchEvent(event);
};
