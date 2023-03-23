import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["form"];

  submitForm(event) {
    event.preventDefault();
    const form = this.formTarget;

    Rails.ajax({
      type: form.method,
      url: form.action,
      data: new FormData(form),
      success: () => {
        // Handle success here
      },
      error: () => {
        // Handle error here
      },
    });
  }
}
