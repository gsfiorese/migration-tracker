import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="generate-numbers"
export default class extends Controller {

  static targets = ["name"]
  connect() {
    console.log("Big nips");
  }
}
