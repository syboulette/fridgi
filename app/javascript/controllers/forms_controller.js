import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets= ["form", "checkbox", "input", "review"] 

  toggleFields(event) {
    const line = event.currentTarget.closest('.line')
    const form = line.querySelector("form")
    const lineInside = line.querySelector(".line-inside")
    lineInside.classList.add("hidden")
    form.classList.remove("hidden")
  }

  toggleReview(event) {
    const reviewLine = event.currentTarget.closest('.review_line')
    const review = reviewLine.querySelector("review")
    reviewLine.classRecipe.add("hidden")
    review.classList.remove("hidden")
  }

  submitForm(event) {
    event.preventDefault()
    const listIngredientIds = this.checkboxTargets.filter(c => c.checked).map(c => c.id)
    this.inputTarget.value = listIngredientIds
    this.formTarget.submit()
  }
}
