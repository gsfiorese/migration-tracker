import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("TabsController connected!");
  }

  static targets = ["content"]

  connect() {
    console.log("TabsController connected");
    this.baseUrl = "/yearly_migration_data"; // Define the base URL for fetching data
  }

  load(event) {
    const sheetName = event.currentTarget.dataset.sheetName; // Get sheet_name from data attribute
    console.log(`Loading data for: ${sheetName}`);
    const targetId = event.currentTarget.getAttribute("aria-controls"); // ID of the tab content container
    const tabContent = document.querySelector(`#${targetId}`);

    // Skip loading if already loaded
    if (tabContent.querySelector(".data-container").innerHTML.trim() !== "") return;

    // Show a loading indicator
    tabContent.querySelector(".loading-message").style.display = "block";

    // Fetch data via AJAX
    fetch(`${this.baseUrl}?sheet_name=${encodeURIComponent(sheetName)}`)
      .then((response) => response.json())
      .then((data) => {
        const container = tabContent.querySelector(".data-container");
        container.innerHTML = data.html; // Populate the data container
        tabContent.querySelector(".loading-message").style.display = "none"; // Hide loading indicator
      })
      .catch((error) => {
        console.error("Error fetching data:", error);
        tabContent.querySelector(".loading-message").textContent = "Error loading data.";
      });
  }
}

console.log(`Loading data for: ${sheetName}`);
