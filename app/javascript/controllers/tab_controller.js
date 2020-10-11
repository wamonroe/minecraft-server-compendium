import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "content", "tab" ]

  select(event) {
    var name = event.target.getAttribute("data-tab-target")
    this.tabTargets.forEach(function(tab){
      if (tab == event.target) {
        tab.classList.add("text-gray-800")
        tab.classList.add("border-gray-800")
        tab.classList.add("cursor-default")
        tab.classList.remove("border-transparent")
        tab.classList.remove("hover:text-gray-800")
        tab.classList.remove("hover:border-gray-800")
      } else {
        tab.classList.add("border-transparent")
        tab.classList.add("hover:text-gray-800")
        tab.classList.add("hover:border-gray-800")
        tab.classList.remove("text-gray-800")
        tab.classList.remove("border-gray-800")
        tab.classList.remove("cursor-default")
      }
    })

    var contentTarget = document.getElementById(name)
    this.contentTargets.forEach(function(content) {
      if (content === contentTarget) {
        content.classList.remove("hidden")
      } else {
        content.classList.add("hidden")
      }
    })
  }
}
