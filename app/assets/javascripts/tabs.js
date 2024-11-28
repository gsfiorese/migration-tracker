document.addEventListener("DOMContentLoaded", () => {
  const tabs = document.querySelectorAll("#myTab .nav-link");
  const dataContainer = document.querySelector(".data-container");
  const loadingMessage = document.querySelector(".loading-message");

  tabs.forEach((tab) => {
    tab.addEventListener("click", (event) => {
      event.preventDefault();
      const sheetName = tab.dataset.tab;

      // Show loading message
      loadingMessage.style.display = "block";
      dataContainer.innerHTML = "";

      // Fetch data from the new route
      fetch(`/yearly_migration/yearly_migration_data/fetch_tab_data?s_sheet_name=${encodeURIComponent(sheetName)}`)
        .then((response) => {
          if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
          }
          return response.json();
        })
        .then((data) => {
          dataContainer.innerHTML = data.html;
          loadingMessage.style.display = "none";
        })
        .catch((error) => {
          console.error("Error loading data:", error);
          loadingMessage.textContent = "Error loading data.";
        });
    });
  });
});
