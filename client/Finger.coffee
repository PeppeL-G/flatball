class @Finger
	
	constructor: () ->
		@x = 0
		@y = 0
		@_isPressing = false
	
	getX: () ->
		return @x
	
	getY: () ->
		return @y
	
	setX: (x) ->
		@x = x
	
	setY: (y) ->
		@y = y
	
	isPressing: () ->
		return @_isPressing
	
	setPressingStatus: (isPressing) ->
		@_isPressing = isPressing