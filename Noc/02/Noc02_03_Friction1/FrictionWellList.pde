
class FrictionWellList {
  ArrayList<FrictionWell> wells = new ArrayList<FrictionWell>();

  FrictionWellList() {
  }

  void addAt(PVector location, float frictionCoefficient) {
    FrictionWell well = locateFrictionWellAt(location);
    if (well == null) {
      addFrictionWell(location, frictionCoefficient);
    }
  }

  void removeAt(PVector location) {
    FrictionWell well = locateFrictionWellAt(location);
    if (well != null) {
      wells.remove(well);
    }
  }

  FrictionWell locateFrictionWellAt(PVector location) {
    for (int i = 0; i < wells.size(); i++) {
      FrictionWell well = wells.get(i);
      if (well.containsPoint(location)) return well;
    }

    return null;
  }

  void addFrictionWell(PVector location, float frictionCoefficient) {
    FrictionWell well = new FrictionWell(location, frictionCoefficient);
    wells.add(well);
  }

  void display() {
    for (int i = 0; i < wells.size(); i++) {
      wells.get(i).display();
    }
  }

  float sumFrictionCoefficientAt(PVector location) {
    float coefficient = 0;

    for (int i = 0; i < wells.size(); i++) {
      FrictionWell well = wells.get(i);

      if (well.containsPoint(location)) {
        coefficient += well.getFrictionCoefficient();
      }
    }

    return coefficient;
  }
}