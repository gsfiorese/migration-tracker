// import { Application } from "@hotwired/stimulus";
// import { definitionsFromContext } from "controllers"; // Make sure this is active
// import "@hotwired/turbo-rails";
// import "bootstrap";

// import "./controllers";
// import "cases_form"; // Import the file from Importmap
// console.log("cases_form.js imported");



// // Initialize Stimulus
// const application = Application.start();
// const context = require.context("controllers", true, /\.js$/); // Dynamically load all controllers
// application.load(definitionsFromContext(context)); // Load the controllers into Stimulus


// Rails UJS (if needed)
import Rails from "@rails/ujs";
Rails.start();
// // import { Application } from "@hotwired/stimulus";
// import "controllers"

import "@hotwired/turbo-rails";
import "bootstrap";
import "cases_form"; // Import the file from Importmap
import "controllers";
console.log("cases_form.js imported")
