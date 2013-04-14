# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
feeds = version: 1 if !window.feeds

feeds.listing =
  load: () ->
    console.log('test')


jQuery(document).ready () ->
  feeds.listing.load()
