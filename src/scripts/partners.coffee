module.exports = ->

  $el = $('#partners-wrap')
  $pager = $('#partners-pager')

  

  partners = []
  blocksNumber = 0
  screensNumber = 0

  rows = 0
  cols = 0
  screen = 0


  $pager.on 'click', '.pager-item', ->
    $this = $(this)

    screen = $this.data('page')
    drawScreen()

    $('#partners-pager .pager-item').removeClass('active')
    $this.addClass('active')


  # partners = [{link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}, {link: '#', img: '/assets/sprite.png'}]  


  draw = ->
    ww =  $(window).height() - 297

    #hack to get width
    c = ''
    for scr in [0..10]
      c  +=  "<div class='partner empty'></div>" 
    $el.html(c)
    wh = $el.width() 

    rows = ww // 210
    cols = wh // 210


    blocksNumber = rows * cols 
    screensNumber = Math.ceil( partners.length / blocksNumber )
    if screensNumber == 0 
      screensNumber = 1

    drawScreen()
    drawPager()




  drawScreen = ->
    curPartners = partners[(screen * blocksNumber)...((screen + 1) * blocksNumber )]
    emptyBlocks = blocksNumber - curPartners.length

    content = ''
    for partner in curPartners
      content +=  "<a class='partner' href='#{partner.link}'><img src='#{partner.img}'></a>"

    for i in [0...emptyBlocks]
      content +=  "<div class='partner empty'></div>"      

    console.log partners, curPartners, emptyBlocks

    $el.html(content)    



  drawPager = ->
    content = ''
    
    unless screensNumber == 1
      for scr in [0...screensNumber]
        content +=  "<div data-page='#{scr}' class='pager-item #{if scr == screen then 'active'}'></div>"

    $pager.html content
    $pager.css 'margin-left', ($el.width() - cols * 210) / 2 + 5 + 'px'



  draw()
  $(window).on 'resize', draw

  $.ajax({
    url: '/Home/Partners',
    dataType:'json'
  }).then (_partners)->
    partners = _partners
    draw()




