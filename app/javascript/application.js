// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener('turbo:visit', (_) => {
  let modal = document.getElementById("modal-loading");
  modal.classList.add("modal-open");
})

document.addEventListener('turbo:submit-start', (_) => {
  let modal = document.getElementById("modal-loading");
  modal.classList.add("modal-open");
})

document.addEventListener('turbo:render', (_) => {
  var modal = document.getElementById("modal-loading");
  modal.classList.remove("modal-open");
})

document.addEventListener('turbo:submit-end', (_) => {
  var modal = document.getElementById("modal-loading");
  modal.classList.remove("modal-open");
})
