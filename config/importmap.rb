# Import the application entry point
pin "application"

# Pin Hotwire dependencies
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

# Pin all Stimulus controllers automatically
pin_all_from "app/javascript/controllers", under: "controllers"

# Pin Bootstrap for JavaScript components
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js", preload: true

# Pin Rails UJS (if needed)
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.0/lib/assets/compiled/rails-ujs.js"

# Pin your custom tabs.js
pin "tabs", to: "tabs.js"

# Pin your custom cases.js
pin "cases", to: "cases.js"
