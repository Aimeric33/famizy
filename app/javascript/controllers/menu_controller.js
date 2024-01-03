import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = [ "menu", "burger", "cross", "button" ]

  connect() {
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden");
    this.burgerTarget.classList.toggle("hidden");
    this.crossTarget.classList.toggle("hidden");
  }
}
