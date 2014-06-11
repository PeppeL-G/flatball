Meteor.startup ->
	
	# Settings.
	ticksPerSecond = 10
	
	# The model.
	game = new Game()
	
	# The view.
	canvas = document.getElementById('canvas')
	width = canvas.clientWidth
	height = canvas.clientHeight
	canvas.setAttribute('width', width)
	canvas.setAttribute('height', height)
	
	# The controller.
	context = canvas.getContext('2d')
	
	tick = () ->
		game.tick()
		game.draw(context, width, height)
	
	setInterval(tick, 1000/ticksPerSecond)