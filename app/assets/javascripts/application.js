// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

window.distanceOfTimeInWords = function (from, to) {
  var distance_in_milliseconds = to - from;
  var distance_in_minutes = Math.round(Math.abs(distance_in_milliseconds / 60000));
  var words = "";
  if (distance_in_minutes == 0) {
    words = "less than a minute";
  } else if (distance_in_minutes == 1) {
    words = "1 minute";
  } else if (distance_in_minutes < 45) {
    words = distance_in_minutes + " minutes";
  } else if (distance_in_minutes < 90) {
    words = "about 1 hour";
  } else if (distance_in_minutes < 1440) {
    words = "about " + Math.round(distance_in_minutes / 60) + " hours";
  } else if (distance_in_minutes < 2160) {
    words = "about 1 day";
  } else if (distance_in_minutes < 43200) {
    words = Math.round(distance_in_minutes / 1440) + " days";
  } else if (distance_in_minutes < 86400) {
    words = "about 1 month";
  } else if (distance_in_minutes < 525600) {
    words = Math.round(distance_in_minutes / 43200) + " months";
  } else if (distance_in_minutes < 1051200) {
    words = "about 1 year";
  } else {
    words = "over " + Math.round(distance_in_minutes / 525600) + " years";
  }

  return words;
};

Date.prototype.timeAgoInWords = function() {
  return distanceOfTimeInWords(this, new Date());
};

Date.prototype.untilInWords = function() {
  return distanceOfTimeInWords(new Date(), this);
};
