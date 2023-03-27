import { Application } from "@hotwired/stimulus"
import NestedForm from 'stimulus-rails-nested-form'
import Rails from "@rails/ujs"
Rails.start()

const application = Application.start()
application.register('nested-form', NestedForm)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
