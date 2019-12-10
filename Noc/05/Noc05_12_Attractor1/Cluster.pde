class Cluster {
  ArrayList<Node> nodes;
  float diameter;
  float strength;
  
  Cluster(int n, float d, Vec2D center) {
    nodes = new ArrayList<Node>();
    diameter = d;
    strength = 0.01;
    
    for (int i = 0; i < n; i++) {
      Node node = new Node(i, center.add(Vec2D.randomVector()));
      physics.addParticle(node);
      nodes.add(node);
    }
    
    connectAllNodes();
  }
  
  void connectAllNodes() {
    int n = nodes.size();
    for (int i = 0; i < n-1; i++) {
      Node a = nodes.get(i);
      
      for (int j = i+1; j < n; j++) {
        Node b = nodes.get(j);
        physics.addSpring(new VerletSpring2D(a, b, diameter, strength));
      }
    }
  }
  
  Node getHeadNode() {
    return nodes.get(0);  
  }
  
  Node getNodeAt(int n) {
    return nodes.get(n);
  }
  
  void display() {
    for (Node n: nodes) {
      n.display();
    }
  }
}