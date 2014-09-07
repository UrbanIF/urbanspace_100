require("./grid")
require("./slides")
drawPartners = require("./partners")


$ ->
  drawPartners()	

# mobile menu
  $("#nav-toggle").on 'click', ->
    $(this).toggleClass("active")
    $('#wrapper').toggleClass("active")



# popup
  popup = $('.popup_overlay')
  popup.on 'click', (event) ->
    e = event or window.event
    popup.hide()  if e.target is this

  $(document).on 'click', '.popup_overlay .close, .popup_overlay .close-btn', 'click', ->
    popup.hide()

  $(document).on 'click', '.block-container .last-block, .plus', ->
    popup.show()
    $.ajax
      type: "GET"
      url: "/Home/AddPopup"
      success: (data) ->
        $(".add-popup").html data

  $(document).on "change", "input[name=Ask]", ->
    value = $(this).val()
    $(".text-notes").hide()
    $(".text-notes[data-type=" + value + "]").show()

  $(document).on "focus", "#Name", ->
    $("#Name").attr "placeholder", "Імя, Прізвище"
    $("#Name").removeClass "error"
    $("#Name").removeClass "input-validation-error"
  $(document).on "focus", "#Phone", ->
    $("#Phone").attr "placeholder", "Телефон"
    $("#Phone").removeClass "error"
  $(document).on "focus", "#Email", ->
    $("#Email").attr "placeholder", "Електропошта"
    $("#Email").removeClass "error"

  $(document).on "click", "#AddPopupBtn", (e)->
    e.preventDefault()
    e.stopPropagation()
    $.ajax
      type: "POST"
      url: "/Home/AddPopup"
      data: $("#AddForm").serialize()
      success: (data) ->
        $(".add-popup").html data


# fullpage slider
  $('#fullpage').fullpage
    anchors: $('#menu li').map(->return $(this).data('menuanchor')),
    menu: '#menu',
    navigation: true, navigationPosition: 'right', navigationTooltips: $('#menu a').map(->return $(this).html()),
    scrollOverflow: true,
    css3: true


    onLeave: (index, nextIndex, direction)->
      if nextIndex == 1
        $('#fullPage-nav').fadeOut(200)
      else if nextIndex == 9
        $('.scroll-down-hint').fadeOut(200)
        $('#fullPage-nav').fadeIn(800)
      else
        $('.scroll-down-hint').fadeIn(800)
        $('#fullPage-nav').fadeIn(800)

    afterRender: ->
      $.ajax({
        url: '/Home/People',
        dataType:'json'
      }).then (people)->
        $('.section.s1 .tableCell').grid(people)

    $('.section.s3 .bg-slider').slides()

  # text float rombus
  $('.s5 .rhombus-text-block').prepend('<div class="lW" style="width:0px;"></div><div class="rW" style="width:15px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:33px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:52px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:70px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:88px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:107px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:125px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:143px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:162px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:180px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:198px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:203px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:184px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:165px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:146px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:127px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:108px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:89px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:69px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:50px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:31px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:12px;"></div><div class="lW" style="width:0px;"></div><div class="rW" style="width:0px;"></div>')
