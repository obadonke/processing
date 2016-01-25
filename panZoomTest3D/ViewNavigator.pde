class ViewNavigator {
  float EASE_FACTOR = 0.85;
  float ZOOM_STEP = 1.05;
  float EASE_MIN_MAGNITUDE = 1.0;
  float MOVEMENT_DELTA = 2;
  float ROTATION_DELTA = 0.1;
  
  int clickMouseX = -1;
  int clickMouseY = -1;
  ViewMode mode = ViewMode.IDLE;
  DragOperation dragOp = DragOperation.NONE;
  CameraPosition activeCameraPos;
  
  Transform base = new Transform();
  Transform lastActiveTransform = new Transform();
  Transform velocityTransform = new Transform();
  Transform easeVelocityTransform = new Transform();

  void HandleUserNavigation(CameraPosition cameraPos) {
    activeCameraPos = cameraPos;
    HandleUserInput();

    Transform activeTransform = CalculateActiveTransform();
    UpdateVelocityTransform(activeTransform);
    TransformView(activeTransform);
  }

  void TransformView(Transform transforms)
  {
    translate(transforms.translation.x, transforms.translation.y);
    scale(transforms.scale);
  }

  void UpdateVelocityTransform(Transform activeTransform)
  {
    velocityTransform = activeTransform.copy();
    velocityTransform.sub(lastActiveTransform);
    lastActiveTransform = activeTransform;
  }

  PVector ViewToModelCoord(float x, float y) {
    PVector result = new PVector(x, y);
    result.sub(base.translation);
    result.mult(1.0/base.scale);
    return result;
  }

  PVector ModelToViewCoord(float x, float y) {
    PVector result = new PVector(x, y);
    result.mult(base.scale);
    result.add(base.translation);
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
    } else if (mode == ViewMode.EASING) {
      if (mousePressed) {
        StopEasing();
        StartDrag();
      } else {
        ApplyEasing();
      }
    } else if (mode == ViewMode.IDLE) {
      if (mousePressed) {
        StartDrag();
      } else if (keyPressed) {
        HandleIdleKeyPress();
      }
    }
  }

  void HandleIdleKeyPress() {
    switch(key) {
    case KeyBinding.KEY_UP:
      MoveCamera(0,-1,0);
      break;
    case KeyBinding.KEY_DOWN:
      MoveCamera(0,1,0);
      break;
    case KeyBinding.KEY_LEFT:
      MoveCamera(-1,0,0);
      break;
    case KeyBinding.KEY_RIGHT:
      MoveCamera(1,0,0);
      break;
    case KeyBinding.KEY_FWD:
      MoveCamera(0,0,-1);
      break;
    case KeyBinding.KEY_BACK:
      MoveCamera(0,0,1);
      break;
    case KeyBinding.KEY_ZOOMIN:
      Zoom(ZoomDirection.IN);
      break;
    case KeyBinding.KEY_ZOOMOUT:
      Zoom(ZoomDirection.OUT);
      break;
    case KeyBinding.KEY_ROLL_CW:
      activeCameraPos.Roll(ROTATION_DELTA);
      break;
    case KeyBinding.KEY_ROLL_CCW:
      activeCameraPos.Roll(-ROTATION_DELTA);
      break;
    case KeyBinding.KEY_PITCH_UP:
      break;
    case KeyBinding.KEY_PITCH_DOWN:
      break;
    case KeyBinding.KEY_YAW_L:
      break;
    case KeyBinding.KEY_YAW_R:
      break;
    }
  }
 
  void MoveCamera(float x, float y, float z) {
    PVector movement = new PVector(x,y,z);
    movement.mult(MOVEMENT_DELTA);
    activeCameraPos.Translate(movement);
  }
  
  void Zoom(ZoomDirection dir) {
    float factor = (dir == ZoomDirection.IN) ? 1/ZOOM_STEP : ZOOM_STEP;
    activeCameraPos.Zoom(factor);
  }
  
  void MouseReleased() {
    if (mode == ViewMode.DRAGGING)
    {
      StopDrag();
    }
  }

  void StartEasing() {
    easeVelocityTransform.set(velocityTransform);
    mode = ViewMode.EASING;
  }

  void ApplyEasing() {
    if (mode != ViewMode.EASING) 
    {
      return;
    }

    if (easeVelocityTransform.translation.mag() > EASE_MIN_MAGNITUDE)
    {
      base.translation.add(easeVelocityTransform.translation);
    }

    easeVelocityTransform.mult(EASE_FACTOR);

    if (!AnyTransformMagGreaterThan(easeVelocityTransform, EASE_MIN_MAGNITUDE))
    {
      StopEasing();
    }
  }


  void StopEasing() {
    easeVelocityTransform = easeVelocityTransform.emptyTransform();
    mode = ViewMode.IDLE;
  }

  Transform CalculateActiveTransform() {
    PVector translation = base.translation.copy();
    if (IsPanInteractive()) 
    {
      translation.x += mouseX-clickMouseX;
      translation.y += mouseY-clickMouseY;
    }

    Transform result = new Transform();
    result.translation = translation;
    result.scale = base.scale;

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
      mode = ViewMode.DRAGGING;
    }
  }

  void StopDrag() {
    if (IsPanInteractive()) {
      base.translation.x += mouseX-clickMouseX;
      base.translation.y += mouseY-clickMouseY;
    } 

    if (AnyTransformMagGreaterThan(velocityTransform, EASE_MIN_MAGNITUDE)) {
      StartEasing();
    } else {
      mode = ViewMode.IDLE;
    }

    dragOp = DragOperation.NONE;
  }
  void StepZoom(int steps) {
    float zoomFactor = (steps > 0) ? steps*ZOOM_STEP : -1.0/(steps*ZOOM_STEP);
    float newZoom = base.scale*zoomFactor;
    if (newZoom > 0.1) 
    {
      AdjustTranslationForZoomChange(zoomFactor);
      base.scale = newZoom;
    }
  }

  void AdjustTranslationForZoomChange(float zoomFactor) {
    float ax = (mouseX-base.translation.x)*(1-zoomFactor);
    float ay = (mouseY-base.translation.y)*(1-zoomFactor);
    base.translation.add(ax, ay);
  }

  boolean AnyTransformMagGreaterThan(Transform t, float mag)
  {
    return t.translation.mag() > mag  || t.rotation.mag() > mag || abs(t.scale) > mag;
  }
}