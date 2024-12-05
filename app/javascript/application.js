// import "@hotwired/turbo-rails"; // Turbo for seamless navigation
// import { Application } from "@hotwired/stimulus";
// import { definitionsFromContext } from "controllers";
import "bootstrap"; // Load Bootstrap
//import "../stylesheets/application.scss"; // Import your SCSS
import "cases_form"; // Import the file from Importmap
console.log("cases_form.js imported");


// Stimulus setup
const application = Application.start();
const context = require.context("controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

// Rails UJS (if needed)
import Rails from "@rails/ujs";
Rails.start();
