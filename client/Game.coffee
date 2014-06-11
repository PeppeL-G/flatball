class @Game
	
	# time: 0
	
	constructor: () ->
		@time = 0
	
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