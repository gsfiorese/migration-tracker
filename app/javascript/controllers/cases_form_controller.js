import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cases-form"
export default class extends Controller {
  connect() {
    console.log("Connected to the casesd controller")
  }
}
