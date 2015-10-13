ViewState state;

// Issues:
//  * Moving mouse across Y axis flips the rotation 180 degrees
//  * After one rotation, translation applies incorrect offset for every move.
//  * After one rotation, scale centering no longer works. maybe algebra won't come to the rescue after all :P

void setup()
{
  size(600, 600);
  state = new ViewState();
  frameRate(60);
}

void draw()
{
  state.HandleUserInput();

  transformView();
  background(80);
  drawStaticSketch();
}

void transformView()
{

  PVector translation = state.GetTranslation();
  translate(translation.x, translation.y);

  float rotation = state.GetRotation();
  rotate(rotation);
  
  scale(state.zoom);
}

void drawStaticSketch()
{
  fill(0, 250, 250);
  stroke(255, 0, 0);
  rect(50, 50, 100, 100);
  rect(500, 50, 100, 100);
  noFill();
  rect(width/2-10, height/2-10, 20, 20);
  stroke(255);
  for (int i = 0; i < width; i+= 50) {
    for (int j = 0; j < height; j += 50) {
      point(i, j);
    }
  }
}

void mouseWheel(MouseEvent event)
{
  state.StepZoom(event.getCount());
}

void mousePressed()
{
  PVector coord = state.ViewToModelCoord(mouseX, mouseY);
  println("Mouse: ",mouseX,",",mouseY);
  print("Zoom: ", state.zoom);
  print(" Rot: ", degrees(state.rotation));
  println(" Tran: ", state.translation);
  println("Co-ord is: ", coord);
  coord = state.ModelToViewCoord(coord.x,coord.y);
  println("Reverse is: ",coord);
  if (abs(coord.x-mouseX) > 1 || abs(coord.y-mouseY) > 1) {
    println("Comparison not so good. :O");
  }
}

enum ViewMode
{
  IDLE, 
    DRAGGING, 
    EASING
}

  enum DragOperation
{
  NONE, 
    PAN, 
    ZOOM, 
    ROTATE
}

  class ViewState 
{
  float EASE_FACTOR = 0.85;
  float ZOOM_STEP = 1.1;

  int clickMouseX = -1;
  int clickMouseY = -1;
  float zoom = 1;
  ViewMode mode = ViewMode.IDLE;
  DragOperation dragOp = DragOperation.NONE;

  PVector translation = new PVector(0, 0);
  PVector lastMouse = new PVector(0, 0);
  PVector velocity = new PVector(0, 0);
  PVector easeVelocity = new PVector(0, 0);
  float rotation = 0;

  PVector ViewToModelCoord(float x, float y) {
    PVector result = new PVector(x,y);
    result.sub(translation);
    result.rotate(-rotation);
    result.mult(1.0/zoom);
    return result;
  }

  PVector ModelToViewCoord(float x, float y) {
    PVector result = new PVector(x,y);
    result.mult(zoom);
    result.rotate(rotation);
    result.add(translation);
    return result;
  }
  
  PVector ModelToViewCoord(PVector p, PVector trans, float rot, float zoom)
  {
    PVector result = p.copy();
    result.mult(zoom);
    result.rotate(rot);
    result.add(trans);
    return result;
  }
  
  boolean IsRotateInteractive() {
    return mode == ViewMode.DRAGGING && dragOp == DragOperation.ROTATE;
  }

  boolean IsPanInteractive() {
    return mode == ViewMode.DRAGGING && dragOp == DragOperation.PAN;
  }

  void HandleUserInput() {
    if (state.mode == ViewMode.DRAGGING) {
      if (!mousePressed) {
        state.MouseReleased();
      }
    } else if (state.mode == ViewMode.EASING) {
      if (mousePressed) {
        state.StopEasing();
        state.StartDrag();
      } else {
        state.ApplyEasing();
      }
    } else if (state.mode == ViewMode.IDLE) {
      if (mousePressed) {
        state.StartDrag();
      }
    }

    velocity.x = mouseX-lastMouse.x;
    velocity.y = mouseY-lastMouse.y;
    lastMouse.x = mouseX;
    lastMouse.y = mouseY;
  }

  void MouseReleased() {
    if (mode == ViewMode.DRAGGING)
    {
      StopDrag();
    }
  }

  void StartEasing() {
    easeVelocity = velocity.copy();
    if (easeVelocity.x < 0 || easeVelocity.y < 0) println("This one! " + easeVelocity.x + "," + easeVelocity.y);
    mode = ViewMode.EASING;
  }

  void ApplyEasing() {
    if (mode != ViewMode.EASING) 
    {
      return;
    }

    translation.x += easeVelocity.x;
    translation.y += easeVelocity.y;
    easeVelocity.mult(EASE_FACTOR);
    if (easeVelocity.mag() < 1) 
    {
      StopEasing();
    }
  }


  void StopEasing() {
    easeVelocity.set(0, 0);
    mode = ViewMode.IDLE;
  }

  PVector GetTranslation() {
    PVector currentTranslation = translation.copy();
    if (IsPanInteractive()) 
    {
      currentTranslation.x += mouseX-state.clickMouseX;
      currentTranslation.y += mouseY-state.clickMouseY;
    }
    if (IsRotateInteractive())
    {
      float extraRotation = CalculateDragRotation();
      PVector extraTranslation = CalculateDragRotationOffset(extraRotation);
      currentTranslation.sub(extraTranslation);
    }
    return currentTranslation;
  }

  float GetRotation() {
    float currentRotation = rotation;
    if (IsRotateInteractive())
    {
      currentRotation += CalculateDragRotation();
    }
    return currentRotation;
  }

  float CalculateDragRotation() {
    int midScreenX = width/2;
    int midScreenY = height/2;
    PVector startDelta = new PVector(clickMouseX - midScreenX, clickMouseY - midScreenY);
    PVector currentDelta = new PVector(mouseX - midScreenX, mouseY - midScreenY);
    
    float startDeltaR = atan2(startDelta.y,startDelta.x);
    float deltaR = atan2(currentDelta.y, currentDelta.x);
    return deltaR - startDeltaR;
  }
  
  PVector CalculateDragRotationOffset(float extraRotation) {
      PVector result = state.ViewToModelCoord(width/2, height/2);
      float newRotation = rotation+extraRotation;
      result = state.ModelToViewCoord(result,translation,newRotation,zoom);
      result.sub(width/2, height/2);
      return result;
  }
  
  void StartDrag() {
    switch (mouseButton) {
    case LEFT:
      dragOp = DragOperation.PAN;
      break;
    case RIGHT:
      dragOp = DragOperation.ROTATE;
      break;
    default:
      dragOp = DragOperation.NONE;
    }

    state.clickMouseX = mouseX;
    state.clickMouseY = mouseY;

    if (dragOp != DragOperation.NONE) {
      state.mode = ViewMode.DRAGGING;
    }
  }

  void StopDrag() {
    if (IsPanInteractive())
    {
      translation.x += mouseX-clickMouseX;
      translation.y += mouseY-clickMouseY; 
      if (velocity.mag() > 1)
      {
        StartEasing();
      } else
      {
        mode = ViewMode.IDLE;
      }
    } else if (IsRotateInteractive())
    {
      float extraRotation = CalculateDragRotation();
      translation.sub(CalculateDragRotationOffset(extraRotation));
      rotation += extraRotation;
      mode = ViewMode.IDLE;
    }
    dragOp = DragOperation.NONE;
  }
  void StepZoom(int steps) {
    float zoomFactor = (steps > 0) ? steps*ZOOM_STEP : -1.0/(steps*ZOOM_STEP);
    float newZoom = zoom*zoomFactor;
    if (newZoom > 0.1) 
    {
      AdjustTranslationForZoomChange(zoomFactor);
      zoom = newZoom;
    }
  }

  void AdjustTranslationForZoomChange(float zoomFactor) {
    float ax = (mouseX-translation.x)*(1-zoomFactor);
    float ay = (mouseY-translation.y)*(1-zoomFactor);
    translation.add(ax, ay);
  }
}