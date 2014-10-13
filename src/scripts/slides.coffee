(($) ->
  $.fn.slides = ->
    currentSlide = 0
    slides = $(this).children('div')

    initTimeout = ->
      window.slideTimeout = window.setTimeout(nextSlide, 5000)

    nextSlide = ->
      currentSlide = if currentSlide==(slides.length - 1) then 0 else currentSlide+1
      slides.removeClass('current-slide')
      $(slides[currentSlide]).addClass('current-slide')
      clearTimeout(window.slideTimeout) if window.slideTimeout?
      initTimeout()

    initTimeout()
) jQuery
