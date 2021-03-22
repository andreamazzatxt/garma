  // This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import AOS from 'aos';
import 'aos/dist/aos.css';
import { BrowserMultiFormatReader } from '@zxing/library';
import { startScanner } from '../plugins/scan'
import { accordion } from '../plugins/accordion'
import { initFlatpickr } from "../plugins/flatpickr";
import { heartSave } from "../plugins/heart";
import { installPWA } from "../plugins/install";
import { flashTimer } from "../plugins/flashes";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
window.addEventListener('load', () => {
  navigator.serviceWorker.register('/service-worker.js').then(registration => {


    var serviceWorker;
    if (registration.installing) {
      serviceWorker = registration.installing;

    } else if (registration.waiting) {
      serviceWorker = registration.waiting;
    } else if (registration.active) {
      serviceWorker = registration.active;
    }
  }).catch(registrationError => {
    console.log('Service worker registration failed: ', registrationError);
  });
});


document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
    startScanner();
    accordion();
    initFlatpickr();
    heartSave();
    flashTimer();
    AOS.init();
    installPWA();
});
