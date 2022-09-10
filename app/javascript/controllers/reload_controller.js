import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    Turbo.visit(location.pathname + location.search, { action: "replace" });
    this.element.remove();
  }
}
