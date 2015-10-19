ViewController controller;

void setup() {
  size(600, 600);
  controller = new ViewController();
  frameRate(60);
}

void draw() {
  controller.HandleUserNavigation();

  background(80);
  drawStaticSketch();
}

void drawStaticSketch() {
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

void mouseWheel(MouseEvent event) {
  controller.StepZoom(event.getCount());
}

void mousePressed() {
  PVector coord = controller.ViewToModelCoord(mouseX, mouseY);
  println("Mouse: ", mouseX, ",", mouseY);
  print("Zoom: ", controller.zoom);
  print(" Rot: ", degrees(controller.baseRotation));
  println(" Tran: ", controller.baseTranslation);
  println("Co-ord is: ", coord);
  coord = controller.ModelToViewCoord(coord.x, coord.y);
  println("Reverse is: ", coord);
  if (abs(coord.x-mouseX) > 1 || abs(coord.y-mouseY) > 1) {
    println("Comparison not so good. :O");
  }
}

enum ViewMode {
  IDLE, 
  DRAGGING, 
  EASING
}

enum DragOperation {
  NONE, 
  PAN, 
  ZOOM, 
  ROTATE
}

class ViewController {
  float EASE_FACTOR = 0.85;
  float ZOOM_STEP = 1.1;

  int clickMouseX = -1;
  int clickMouseY = -1;
  float zoom = 1;
  ViewMode mode = ViewMode.IDLE;
  DragOperation dragOp = DragOperation.NONE;

  PVector baseTranslation = new PVector(0, 0);
  PVector lastMouse = new PVector(0, 0);
  PVector velocity = new PVector(0, 0);
  PVector easeVelocity = new PVector(0, 0);
  float baseRotation = 0;

  void HandleUserNavigation() {
    HandleUserInput();
    TransformView();
  }
  
  void TransformView()
  {
    PVector translation = CalculateActiveTranslation();
    translate(translation.x, translation.y);

    float rotation = controller.CalculateActiveRotation();
    rotate(rotation);

    scale(controller.zoom);
  }

  PVector ViewToModelCoord(float x, float y) {
    PVector result = new PVector(x, y);
    result.sub(baseTranslation);
    result.rotate(-baseRotation);
    result.mult(1.0/zoom);
    return result;
  }

  PVector ModelToViewCoord(float x, float y) {
    PVector result = new PVector(x, y);
    result.mult(zoom);
    result.rotate(baseRotation);
    result.add(baseTranslation);
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
    if (mode == ViewMode.DRAGGING) {
      if (!mousePressed) {
        MouseReleased();
      }
    } else if (controller.mode == ViewMode.EASING) {
      if (mousePressed) {
        StopEasing();
        StartDrag();
      } else {
        ApplyEasing();
      }
    } else if (controller.mode == ViewMode.IDLE) {
      if (mousePressed) {
        StartDrag();
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
    mode = ViewMode.EASING;
  }

  void ApplyEasing() {
    if (mode != ViewMode.EASING) 
    {
      return;
    }

    baseTranslation.x += easeVelocity.x;
    baseTranslation.y += easeVelocity.y;
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

  PVector CalculateActiveTranslation() {
    PVector translation = baseTranslation.copy();
    if (IsPanInteractive()) 
    {
      translation.x += mouseX-clickMouseX;
      translation.y += mouseY-clickMouseY;
    }
    if (IsRotateInteractive())
    {
      float extraRotation = CalculateDragRotationDelta();
      PVector extraTranslation = CalculateRotationTranslationOffset(extraRotation);
      translation.sub(extraTranslation);
    }
    return translation;
  }

  float CalculateActiveRotation() {
    float rotation = baseRotation;
    if (IsRotateInteractive())
    {
      rotation += CalculateDragRotationDelta();
    }
    return rotation;
  }

  float CalculateDragRotationDelta() {
    int midScreenX = width/2;
    int midScreenY = height/2;
    PVector startDelta = new PVector(clickMouseX - midScreenX, clickMouseY - midScreenY);
    PVector currentDelta = new PVector(mouseX - midScreenX, mouseY - midScreenY);

    float startDeltaR = atan2(startDelta.y, startDelta.x);
    float deltaR = atan2(currentDelta.y, currentDelta.x);
    return deltaR - startDeltaR;
  }

  PVector CalculateRotationTranslationOffset(float extraRotation) {
    PVector result = ViewToModelCoord(width/2, height/2);
    float newRotation = baseRotation+extraRotation;
    result = ModelToViewCoord(result, baseTranslation, newRotation, zoom);
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

    clickMouseX = mouseX;
    clickMouseY = mouseY;

    if (dragOp != DragOperation.NONE) {
      controller.mode = ViewMode.DRAGGING;
    }
  }

  void StopDrag() {
    if (IsPanInteractive())
    {
      baseTranslation.x += mouseX-clickMouseX;
      baseTranslation.y += mouseY-clickMouseY; 
      if (velocity.mag() > 1)
      {
        StartEasing();
      } else
      {
        mode = ViewMode.IDLE;
      }
    } else if (IsRotateInteractive())
    {
      float extraRotation = CalculateDragRotationDelta();
      ApplyRotationDeltaToBase(extraRotation);
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

  void ApplyRotationDeltaToBase(float rotationDelta) {
      baseTranslation.sub(CalculateRotationTranslationOffset(rotationDelta));
      baseRotation += rotationDelta;
  }
  
  void AdjustTranslationForZoomChange(float zoomFactor) {
    float ax = (mouseX-baseTranslation.x)*(1-zoomFactor);
    float ay = (mouseY-baseTranslation.y)*(1-zoomFactor);
    baseTranslation.add(ax, ay);
  }
}