// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require ("social-share-button")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

import { initSidenavOnClick } from '../components/sidenav.js';
import { initExpandableSearch } from '../components/expandable_search.js';
import { initNotificationsCable } from '../channels/notifications.js';

import "controllers";


import { algoliaSearch } from "../plugins/init_algolia_search.js";
algoliaSearch();

import { initSelect2 } from "../plugins/init_select2";


// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  initSelect2();

  initSidenavOnClick();
  initExpandableSearch();
  initNotificationsCable();
  // responsiveSearch();

});

// const responsiveSearch = () => {
//   addEventListener("keyup", event => {
//     const input = document.getElementById("search").value;
//     console.log(input);
//     // query select card container of the suggestion
//     // send search term to Algolia API
//     // loop through how many searches we want to display
//     // create a new html element (this is the suggestion) - creating string, putting inside a div (interpolate)
//     //
//   });
// };

