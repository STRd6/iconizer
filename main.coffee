Drop = require "./lib/drop"

Drop document, (e) ->
  file = e.dataTransfer.files[0]

  if file
    url = URL.createObjectURL(file)
    
    new Promise (resolve, reject) ->
      img = new Image

      img.onload = ->
        resolve img
      img.onerror = reject
      img.src = url
    .then (img) ->
      canvases.forEach (canvas) ->
        context = canvas.getContext('2d')
        context.clearRect(0, 0, canvas.width, canvas.height)
        context.drawImage( img,
          0, 0, img.width, img.height, 
          0, 0, canvas.width, canvas.height
        )

canvases = [16, 32, 48, 64, 128].map (size) ->
  
  canvas = document.createElement 'canvas'
  canvas.width = canvas.height = size
  ctx = canvas.getContext('2d')
  ctx.fillStyle = 'blue'
  ctx.fillRect(0, 0, canvas.width, canvas.height)
  document.body.appendChild canvas
