document.addEventListener("DOMContentLoaded", () => {
  console.log("tabs.js loaded");
  const tabs = document.querySelectorAll(".nav-link");

  tabs.forEach((tab) => {
    tab.addEventListener("click", (event) => {
      const tabName = tab.getAttribute("data-tab-name"); // Get the tab name
      console.log(`Tab clicked: ${tabName}`);
      const targetId = tab.getAttribute("data-bs-target").replace("#", ""); // Get the ID of the target tab content
      const targetContent = document.getElementById(targetId); // Find the target tab content element

      if (!targetContent) return;

      const loadingMessage = targetContent.querySelector(".loading-message");
      const dataContainer = targetContent.querySelector(".data-container");

      // Show loading message
      loadingMessage.style.display = "block";
      dataContainer.innerHTML = "";

      // Fetch data for the tab
      const fetchUrl = `/yearly_migration/yearly_migration_data/fetch_tab_data?s_sheet_name=${tabName}`;
      console.log(`Fetching data from: ${fetchUrl}`);
      fetch(fetchUrl)
        .then((response) => {
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
          return response.json();
        })
        .then((data) => {
          console.log("Fetch response:", data);
          // Populate the data container with the fetched HTML
          dataContainer.innerHTML = data.html;
          loadingMessage.style.display = "none"; // Hide the loading message
        })
        .catch((error) => {
          console.error("Error fetching tab data:", error);
          loadingMessage.textContent = "Error loading data.";
        });
    });
  });

  // Trigger click on the default active tab to load its content
  document.querySelector(".nav-link.active").click();
});
