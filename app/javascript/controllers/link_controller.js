import { Controller } from "stimulus"

export default class extends Controller {
  open() {
    window.location = this.data.get("url")
  }
}
