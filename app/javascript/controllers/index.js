// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import ReloadController from "./reload_controller"
import ModalErrorController from "./modal_error_controller"

application.register("reload", ReloadController)
application.register("modal-error", ModalErrorController)
