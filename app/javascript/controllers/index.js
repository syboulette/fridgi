import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"
import { application } from "./application"
import HelloController from "./hello_controller"

const context = require.context(".", true, /\.js$/)
const definitions = definitionsFromContext(context)

application.load(definitions)
application.register("hello", HelloController)
