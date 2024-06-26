# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
# pin "bootstrap", to: "bootstrap.min.js", preload: true
# pin "@popperjs/core", to: "popper.js", preload: true
pin "@stimulus-components/auto-submit", to: "https://ga.jspm.io/npm:@stimulus-components/auto-submit@6.0.0/dist/stimulus-auto-submit.mjs"
