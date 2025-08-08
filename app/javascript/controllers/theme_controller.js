import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon"]

  connect() {
    this.loadTheme()
  }

  toggle() {
    const currentTheme = document.documentElement.getAttribute('data-theme')
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark'
    
    this.setTheme(newTheme)
    this.updateIcon(newTheme)
  }

  setTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme)
    localStorage.setItem('theme', theme)
  }

  loadTheme() {
    const savedTheme = localStorage.getItem('theme')
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches
    
    let theme = savedTheme || (prefersDark ? 'dark' : 'light')
    this.setTheme(theme)
    this.updateIcon(theme)
  }

  updateIcon(theme) {
    if (this.hasIconTarget) {
      const icon = this.iconTarget
      if (theme === 'dark') {
        icon.classList.remove('bi-moon-fill')
        icon.classList.add('bi-sun-fill')
      } else {
        icon.classList.remove('bi-sun-fill')
        icon.classList.add('bi-moon-fill')
      }
    }
  }
}
