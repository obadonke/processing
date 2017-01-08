// Based on The Nature of Code by Daniel Shiffman
// http://natureofcode.com

// An uneven surface

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
Box2DProcessing box2d;

// An ArrayList of particles that will fall on the surface
ArrayList<Particle> particles;

// An object to store information about the uneven surface
Surface surface;

void setup() {
  size(383,200);

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);

  particles = new ArrayList<Particle>();
  surface = new Surface();
}

void draw() {
  // If the mouse is pressed, we make new particles
  if (mousePressed) {
    float sz = random(2,6);
    particles.add(new Particle(mouseX,mouseY,sz));
  }

  // We must always step through time!
  box2d.step();

  background(255);

  surface.display();

  for (Particle p: particles) {
    p.display();
  }

  // Particles that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    if (p.done()) {
      particles.remove(i);
    }
  }
}