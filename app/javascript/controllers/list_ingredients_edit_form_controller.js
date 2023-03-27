import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["form"];

  openEditForm(event) {
    event.preventDefault();
    const editButton = event.currentTarget;
    const form = editButton.nextElementSibling;
    form.classList.toggle("hidden");
  }
}
