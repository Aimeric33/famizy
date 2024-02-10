import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="list-item"
export default class extends Controller {
  static targets = ["button", "name"]
  static values = { id: Number, path: String }

  connect() {
  }

  done() {
    fetch(`/${this.pathValue}/${this.idValue}`, {
      method: 'PATCH',
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
      },
      body: JSON.stringify({ done: true }),
    })
      .then(response => response.text())
      .then(data => {
        this.nameTarget.classList.add('text-gray-500', 'line-through')
        this.nameTarget.classList.remove('text-gray-800')
        this.buttonTarget.innerHTML = `<svg data-slot="icon" class="w-6 h-6" fill="none" stroke-width="1.5" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 12.75 6 6 9-13.5"></path>
                                      </svg>`
        this.buttonTarget.setAttribute('data-action', 'click->list-item#undone')
      });
  }

  undone() {
    fetch(`/${this.pathValue}/${this.idValue}`, {
      method: 'PATCH',
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
      },
      body: JSON.stringify({ done: false }),
    })
      .then(response => response.text())
      .then(data => {
        this.nameTarget.classList.remove('text-gray-500', 'line-through')
        this.nameTarget.classList.add('text-gray-800')
        this.buttonTarget.innerHTML = `<svg data-slot="icon" class="w-6 h-6" fill="none" stroke-width="1.5" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M5.25 7.5A2.25 2.25 0 0 1 7.5 5.25h9a2.25 2.25 0 0 1 2.25 2.25v9a2.25 2.25 0 0 1-2.25 2.25h-9a2.25 2.25 0 0 1-2.25-2.25v-9Z"></path>
                                      </svg>`
        this.buttonTarget.setAttribute('data-action', 'click->list-item#done')
      });
  }
}
