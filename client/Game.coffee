class @Game
	
	# time: 0
	# pitch: Pitch
	
	constructor: () ->
		
		# Settings.
		pitchWidth = 100
		pitchHeight = 150
		
		# Initialize the game.
		@time = 0
		@pitch = new Pitch(pitchWidth, pitchHeight)
	
	tick: () ->
		@time++
	
	draw: (context, width, height) ->
		
		# Draw background.
		context.fillStyle = 'gray'
		context.fillRect(0, 0, width, height)
		
		# Draw current time.
		context.font = '20px Georgia'
		context.fillStyle = 'black'
		context.fillText("Time: #{@time}", 10, 50)
		
		# Draw the pitch in the middle.
		scale = Math.min(width/@pitch.getWidth(), height/@pitch.getHeight()) / 1.1
		x0 = width/2 - scale*@pitch.getWidth()/2 - 10
		y0 = height/2 - scale*@pitch.getHeight()/2 - 10
		@pitch.draw(context, x0, y0, scale)