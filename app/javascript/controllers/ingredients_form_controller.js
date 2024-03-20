import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ingredients-form"
export default class extends Controller {
  static targets = ["fieldsContainer"]
  connect() {
  }

  addField(event) {
    console.log("Adding field");
    event.preventDefault();
    const lastId = this.fieldsContainerTarget.lastElementChild.id
    const newId = parseInt(lastId, 10) + 1;
    const newFieldset = this.fieldsContainerTarget.firstElementChild.outerHTML
      .replace(/id="0"/g, `id="${newId}"`)
      .replace(/\[0\]/g, `[${newId}]`)
      .replace(/attributes_0/g, `attributes_${newId}`)

    this.fieldsContainerTarget.insertAdjacentHTML("beforeend", newFieldset);
  }
}
