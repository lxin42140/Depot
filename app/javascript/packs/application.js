// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "packs/bootstrap"
import $ from 'jquery';
import "select2";

window.$ = window.jQuery = window.jquery = jQuery;
global.toastr = require("toastr");
require("@nathanvda/cocoon")
require('datatables.net-bs4')

Rails.start()
Turbolinks.start()
ActiveStorage.start()