import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "menu" ]

  connect() {
    if (this.hasMenuTarget) {
      // Clone the menu target and remove
      this.menu = this.menuTarget.cloneNode(true)
      this.menuTarget.remove()

      // Create an overlay
      this.overlay = document.createElement("button")
      this.overlay.classList.add("fixed", "inset-0", "cursor-default")
      this.overlay.setAttribute("tabindex", "-1")
      this.overlay.setAttribute("data-action", "dropdown#hide")

      // Flag menu as not opened
      this.data.set("open", "false")
    }
  }

  show(event) {
    this.preventDefaultEvent(event)
    if (typeof this.menu !== "undefined") {
      this.data.set("open", "true")
      this.element.appendChild(this.menu)
      this.element.insertBefore(this.overlay, this.menu)
    }
  }
  
  toggle(event) {
    this.preventDefaultEvent(event)
    if (typeof this.menu !== "undefined") {
      if (this.data.get("open") === "false") {
        this.show()
      } else {
        this.hide()
      }
    }
  }

  hide(event) {
    this.preventDefaultEvent(event)
    if (this.menu) {
      this.data.set("open", "false")
      this.menu.remove()
      this.overlay.remove()
    }
  }

  preventDefaultEvent(event) {
    if (typeof event !== "undefined") {
      event.preventDefault()
      event.stopPropagation()
    }
  }
}
