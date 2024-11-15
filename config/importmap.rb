# config/importmap.rb

pin "application"
pin "@hotwired/turbo-rails", to: "https://cdn.jsdelivr.net/npm/@hotwired/turbo@7.0.0/dist/turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://cdn.jsdelivr.net/npm/stimulus@3.0.0/dist/stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"
