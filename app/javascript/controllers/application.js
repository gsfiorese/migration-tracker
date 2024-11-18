import { Application } from "@hotwired/stimulus"
import LogController from "./controllers/log_controller"

const application = Application.start()
application.register("log", LogController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
