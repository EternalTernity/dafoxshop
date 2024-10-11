import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autohide"
export default class extends Controller {
  connect() {
    setTimeout(()=>{
      this.close()
    },3000)
  }

  close(){
    this.element.remove()
  }
}
