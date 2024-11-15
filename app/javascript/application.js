import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "controllers"
import "bootstrap"
import "../stylesheets/application.scss"

// Stimulus setup
const application = Application.start()
const context = require.context("controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

// config Rails UJS
import Rails from "@rails/ujs"
Rails.start()
