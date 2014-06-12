class @Finger
	
	constructor: () ->
		@x = 0
		@y = 0
		@_isPressing = false
		@_wasPressing = false
	
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
	
	wasPressing: () ->
		return @_wasPressing
	
	setPressingStatus: (isPressing) ->
		@_wasPressing = @_isPressing
		@_isPressing = isPressing