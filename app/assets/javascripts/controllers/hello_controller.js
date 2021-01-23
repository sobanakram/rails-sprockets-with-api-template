import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
    console.log("Heading Updated using Stimulus JS")
  }
}
