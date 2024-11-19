import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["logList", "loadMoreBtn"];

  appendLogs(event) {
    const responseHTML = event.detail[2].responseText;
    this.logListTarget.insertAdjacentHTML("beforeend", responseHTML);

    if (responseHTML.trim() === "") {
      this.loadMoreBtnTarget.style.display = "none";
    }
  }
}
