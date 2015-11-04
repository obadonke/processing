## Background
The aim of this processing sketch is to construct a simple method of navigating a 3D scene using mouse and keyboard input. 

I'm developing the sketch in a very adhoc loose manner, the theory being that I'm just having a bit of fun coding in my spare time.

## Status
### 3rd November 2015
This exercise is taking too long due to breaks so going to focus on adding basic keyboard navigation that manipulates the camera position.

### 29th October 2015
I've just copied the 2D navigation code I wrote in panZoomTest to a basic 3D scene and begun the conversion process.

Rotation is completely borked. Translation in X and Y with easing seems to work "out of the box". 

It's looking like the best course of action is to strip out most of the code in ViewNavigator, leaving just the shell that handles turning user input into actionable operations with state. We'll see.

## Keyboard Navigation Bindings
 * w = move up
 * s = move down
 * a = move left
 * d = move right
 * q = move forward(zoom+)
 * e = move back (zoom-)
 * j = roll anti-clockwise
 * l = roll clockwise
 * i = pitch up
 * k = pitch down
 * u = yaw left
 * o = yaw right
