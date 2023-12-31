import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['menu', 'button', 'menuItem']
  static values = { open: Boolean, default: false }

  connect() {
    if (this.hasButtonTarget) {
      this.buttonTarget.addEventListener("keydown", this._onMenuButtonKeydown)
      this.buttonTarget.setAttribute("aria-haspopup", "true")
    }
  }

  disconnect() {
    if (this.hasButtonTarget) {
      this.buttonTarget.removeEventListener("keydown", this._onMenuButtonKeydown)
      this.buttonTarget.removeAttribute("aria-haspopup")
    }
  }

  openValueChanged() {
    if (this.openValue === true && this.hasMenuItemTarget) {
      this.menuItemTargets[0].focus()
    }
  }

  show() {
    this.openValue = true;
    this.menuTarget.classList.remove('hidden');
  }

  hide(event) {
    if (event.target.nodeType && this.element.contains(event.target) === false && this.openValue) {
      this.openValue = false
      this.menuTarget.classList.add('hidden');
    }
  }

  toggle() {
    this.openValue = !this.openValue
    this.menuTarget.classList.toggle('hidden');
  }

  nextItem() {
    const nextIndex = Math.min(this.currentItemIndex + 1, this.menuItemTargets.length - 1)
    this.menuItemTargets[nextIndex].focus()
  }

  previousItem() {
    const previousIndex = Math.max(this.currentItemIndex - 1, 0)
    this.menuItemTargets[previousIndex].focus()
  }

  get currentItemIndex() {
    return this.menuItemTargets.indexOf(document.activeElement)
  }
}
