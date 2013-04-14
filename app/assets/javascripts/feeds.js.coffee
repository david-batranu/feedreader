# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
feeds = version: 1 if !window.feeds

feeds.listing =
  load: () ->
    self = this
    self.loadFeeds()

  loadFeeds: () ->
    self = this
    jQuery.ajax(
      url: '/feeds.json'
      success: (data) ->
        self.renderFeeds(data)
    )

  renderFeeds: (data) ->
    tabs = jQuery('#feeddisplay .nav-tabs')
    panes = jQuery('#feeddisplay .tab-content')
    tabs.empty()
    panes.empty()
    jQuery.each(data, (i, o) ->
      console.log(i, o)
      tab = jQuery('<li><a data-toggle="tab">')
      a = jQuery('a', tab)
      a.attr('href', '#' + o.id)
      a.text(o.title)
      tabs.append(tab)

      pane = jQuery('<div class="tab-pane">')
      pane.attr('id', o.id)
      jQuery.ajax(
        url: '/feeds/' + o.id + '/updatebody'
        success: (data) ->
          console.log(data)
          jQuery.each(data, (i, o) ->
            dl = jQuery('<dl>')
            dt = jQuery('<dt>')
            dt.text(o.title)
            date = jQuery('<small class="pull-right muted">')
            date.text(o.published)
            dt.append(date)
            dd = jQuery('<dd>')
            dd.hide()
            if o.content
              dd.html(o.content)
            else
              dd.text('No feed data!')
            dt.on('click', () ->
              jQuery(this).next().toggle()
            )
            dl.append(dt)
            dl.append(dd)
            pane.append(dl)
          )
      )
      panes.append(pane)
    )


jQuery(document).ready () ->
  feeds.listing.load()
