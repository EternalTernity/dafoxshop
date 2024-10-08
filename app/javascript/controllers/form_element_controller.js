import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-element"
export default class extends Controller {
  static targets =["autoSubmitBtn"]
  connect() {
    this.autoSubmitBtnTarget.hidden=true
  }

  autoSubmit(){
    this.autoSubmitBtnTarget.click()
  }
}
