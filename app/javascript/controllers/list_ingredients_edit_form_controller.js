import { Controller } from "stimulus";

const editButton

export default class extends Controller {
  static targets = ["form"];

  openEditForm(event) {
    event.preventDefault();
    this.formTarget.classList.toggle("hidden");
  }
}