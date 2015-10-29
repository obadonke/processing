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

class ViewNavigator {
  float EASE_FACTOR = 0.85;
  float ZOOM_STEP = 1.05;
  float EASE_MIN_MAGNITUDE = 1.0;
  
  int clickMouseX = -1;
  int clickMouseY = -1;
  ViewMode mode = ViewMode.IDLE;
  DragOperation dragOp = DragOperation.NONE;

  Transform base = new Transform();
  Transform lastActiveTransform = new Transform();
  Transform velocityTransform = new Transform();
  Transform easeVelocityTransform = new Transform();
  
  void HandleUserNavigation() {
    HandleUserInput();
    
    Transform activeTransform = CalculateActiveTransform();
    UpdateVelocityTransform(activeTransform);
    TransformView(activeTransform);
  }

  void TransformView(Transform transforms)
  {
    translate(transforms.translation.x, transforms.translation.y);
    //rotateX(transforms.rotation.x);
    //rotateY(transforms.rotation.y);
    //rotateZ(transforms.rotation.z);
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
    //result.rotate(-base.rotation);
    result.mult(1.0/base.scale);
    return result;
  }

  PVector ModelToViewCoord(float x, float y) {
    PVector result = new PVector(x, y);
    result.mult(base.scale);
    //result.rotate(base.rotation);
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
      }
    }
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

    //if (abs(degrees(easeVelocityTransform.rotation)) > EASE_MIN_MAGNITUDE) {
    //  ApplyRotationDeltaToBase(easeVelocityTransform.rotation);
    //}
    
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
    float rotationDelta = 0;
    //float rotation = base.rotation;
    //if (IsRotateInteractive())
    //{
    //  rotationDelta = CalculateDragRotationDelta();
    //  rotation += rotationDelta;
    //}

    PVector translation = base.translation.copy();
    if (IsPanInteractive()) 
    {
      translation.x += mouseX-clickMouseX;
      translation.y += mouseY-clickMouseY;
    }
    //if (rotationDelta != 0)
    //{
    //  PVector translationRotOffset = CalculateRotationTranslationOffset(rotationDelta);
    //  translation.sub(translationRotOffset);
    //}

    Transform result = new Transform();
    result.translation = translation;
    //result.rotation = rotation;
    result.scale = base.scale;

    return result;
  }

  //float CalculateDragRotationDelta() {
  //  int midScreenX = width/2;
  //  int midScreenY = height/2;
  //  PVector startDelta = new PVector(clickMouseX - midScreenX, clickMouseY - midScreenY);
  //  PVector currentDelta = new PVector(mouseX - midScreenX, mouseY - midScreenY);

  //  float startDeltaR = atan2(startDelta.y, startDelta.x);
  //  float deltaR = atan2(currentDelta.y, currentDelta.x);
  //  return deltaR - startDeltaR;
  //}

  //PVector CalculateRotationTranslationOffset(float rotationDelta) {
  //  PVector result = ViewToModelCoord(width/2, height/2);
  //  float newRotation = base.rotation+rotationDelta;
  //  result = ModelToViewCoord(result, base.translation, newRotation, base.scale);
  //  result.sub(width/2, height/2);
  //  return result;
  //}

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
    //else if (IsRotateInteractive()) {
    //  float extraRotation = CalculateDragRotationDelta();
    //  ApplyRotationDeltaToBase(extraRotation);
      
    //  velocityTransform.translation.set(0,0);
    //}
    
    if (AnyTransformMagGreaterThan(velocityTransform,EASE_MIN_MAGNITUDE))  {
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

  //void ApplyRotationDeltaToBase(float rotationDelta) {
  //  base.translation.sub(CalculateRotationTranslationOffset(rotationDelta));
  //  base.rotation += rotationDelta;
  //}

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