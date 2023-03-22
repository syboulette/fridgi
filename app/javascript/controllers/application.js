import { Application } from "@hotwired/stimulus"
import NestedForm from 'stimulus-rails-nested-form'



// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
