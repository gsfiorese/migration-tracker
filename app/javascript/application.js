import "@hotwired/turbo-rails"
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import "bootstrap"
import "../stylesheets/application.scss"

// Stimulus setup
const application = Application.start()
const context = require.context("controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
