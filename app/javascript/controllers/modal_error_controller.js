import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  hide() {
    let modal = document.getElementById("modal-error");
    modal.classList.remove("modal-open");
  }
}
