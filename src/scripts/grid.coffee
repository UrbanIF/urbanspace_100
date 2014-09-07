(($) ->
  $.fn.grid = (items)->
    progressBar = {}
    filled = {}
    itemsPerLine = 15
    itemsLines = 7
    pagePadding = 40
    pagePaddingTop = 70
    borderWidth = 1
    menuHeight = 60
    that = $(this)

    createContainer = ->
      container = $ '<div/>',
        class: 'block-container'
      container.width((size+borderWidth*2)*itemsPerLine).height((size+borderWidth*2)*itemsLines)
      that.append(container)
      container

    addBlock = (block, size) ->
      block.width(size).height(size)
      container.append(block)

    addFirstBlock = ->
      firstBlock = $ '<div/>',
        class: 'first-block'
      addBlock(firstBlock, size*2+(borderWidth*2))

    buildGrid = ->
      for i in [1..100]
        div = $ '<div/>',
          class: 'main-block',
          id: "item-#{i}"
        addBlock(div, size)

    addLastBlock = ->
      lastBlock = $ '<div/>',
        class: 'last-block'
      addBlock(lastBlock, size)

    insertImages = ->
      for item in items
        itemObj = $("#item-#{item.Cell + 1}")
        itemObj.addClass('active').css('background', "url(#{item.Image}) no-repeat")
          .css('background-size', 'cover')
        $('.tooltip-container .tooltip a').hide()
        if item.Facebook?
          $('.tooltip-container .tooltip .facebook').css('display','inline-block').prop('href', item.Facebook)
        if item.Twitter?
          $('.tooltip-container .tooltip .twitter').css('display','inline-block').prop('href', item.Twitter)
        if item.Instagram?
          $('.tooltip-container .tooltip .instagram').css('display','inline-block').prop('href', item.Instagram)
        if item.Google?
          $('.tooltip-container .tooltip .google').css('display','inline-block').prop('href', item.Google)
        if item.Tumblr?
          $('.tooltip-container .tooltip .tumblr').css('display','inline-block').prop('href', item.Tumblr)

        $('.tooltip-container .tooltip h5').text item.Name
        $('.tooltip-container .tooltip .title').text item.SubTitle
        itemObj.tooltipster
          interactive: true
          position: 'right'
          theme: 'urban'
          onlyOne: true
          content: $('.tooltip')

    insertCounter = ->
      progressInfo = $ '<div/>',
        class: 'progress-info'
        text: "#{items.length} / 100"
      container.append(progressInfo)

    calculateProgress = ->
      progressInfoWidth = $('.progress-info').width()
      progressBarWidth = container.width() - progressInfoWidth - 10
      progressBar.width(progressBarWidth)

      filled.width(progressBarWidth / 100 * items.length)

    insertProgress = ->
      progressBar = $ '<div/>',
        class: 'progress-bar'
      filled = $ '<div/>',
        class: 'filled'
      progressBar.append(filled)
      container.append(progressBar)
      calculateProgress()

    calculateSize = ->
      masterContainerWidth = $(window).width()
      masterContainerHeight = $(window).height()
      blockWidth = Math.floor((masterContainerWidth - pagePadding)/itemsPerLine)#-(borderWidth*2)
      blockHeight = Math.floor((masterContainerHeight - menuHeight - pagePaddingTop)/itemsLines)#-(borderWidth*2)
      size = if blockHeight < blockWidth then blockHeight else blockWidth
      size

    reinitGrid = ->
      size = calculateSize()
      container.width((size+borderWidth*2)*itemsPerLine).height((size+borderWidth*2)*itemsLines)
      $('.first-block').width(size*2+(borderWidth*2)).height(size*2+(borderWidth*2))
      $('.last-block').width(size).height(size)
      $('.main-block').width(size).height(size)
      container.css('margin', "#{(menuHeight+pagePaddingTop/2)-20}px auto")
      calculateProgress()
    size = calculateSize()
    container = createContainer()
    addFirstBlock()
    buildGrid()
    addLastBlock()
    insertImages()
    insertCounter()
    insertProgress()
    reinitGrid()
    initTimeout = ->
      clearTimeout(window.timeout) if window.timeout?
      window.timeout = window.setTimeout(reinitGrid, 1000)

    $(window).on 'resize', initTimeout


) jQuery
