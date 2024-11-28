// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

// Register all controllers defined in the import map under controllers/**/*_controller
eagerLoadControllersFrom("controllers", application)

// Explicitly import tabs_controller
import TabsController from "./tabs_controller"
application.register("tabs", TabsController)
