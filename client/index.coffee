Meteor.startup ->
	
	# Settings.
	ticksPerSecond = 20
	
	# The model.
	finger = new Finger()
	game = new Game(finger)
	
	# The view.
	canvas = document.getElementById('canvas')
	width = canvas.clientWidth
	height = canvas.clientHeight
	canvas.setAttribute('width', width)
	canvas.setAttribute('height', height)
	
	# The controller.
	mouseX = 0
	mouseY = 0
	isMouseButtonPressed = false
	
	mouseMoveHandler = (event) ->
		mouseX = event.x
		mouseY = event.y
		isMouseButtonPressed = (event.which == 1)
	mouseDownHandler = (event) ->
		mouseX = event.x
		mouseY = event.y
		isMouseButtonPressed = (event.which == 1)
	mouseUpHandler = (event) ->
		mouseX = event.x
		mouseY = event.y
		isMouseButtonPressed = false
	canvas.addEventListener('mousemove', mouseMoveHandler)
	canvas.addEventListener('mousedown', mouseDownHandler)
	canvas.addEventListener('mouseup', mouseUpHandler)
	
	context = canvas.getContext('2d')
	tick = () ->
		finger.setX(mouseX)
		finger.setY(mouseY)
		finger.setPressingStatus(isMouseButtonPressed)
		game.tick()
		game.draw(context, width, height)
	
	setInterval(tick, 1000/ticksPerSecond)