class Tile {
  String top;
  String right;
  String bottom;
  String left;
  boolean collapsed;
  ArrayList<Tile> options;
  int tileIndex;
  int entropy;

  Tile(String top, String right, String bottom, String left, int index) {
    this.top = top;
    this.right = right;
    this.bottom = bottom;
    this.left = left;
    this.collapsed = false;
    this.options = new ArrayList<Tile>(tiles); // Initialize options with all possible tiles
    this.tileIndex = index;
    this.entropy = tiles.size();
  }

  Tile() {
    this.collapsed = false;
    this.options = new ArrayList<Tile>(tiles); // Initialize options with all possible tiles
    this.tileIndex = -1;
    this.entropy = tiles.size();
  }

  void collapse(Tile tile) {
    this.top = tile.top;
    this.right = tile.right;
    this.bottom = tile.bottom;
    this.left = tile.left;
    this.tileIndex = tile.tileIndex;
    this.collapsed = true;
    this.entropy = 0; // Once collapsed, entropy is zero
    this.options.clear(); // Clear options after collapse
  }

  void display(int x, int y) {
    if (collapsed && tileIndex >= 0) {
      image(img[tileIndex], x, y, DIM, DIM);
    }
  }

  boolean isCollapsed() {
    return collapsed;
  }

  boolean matches(Tile tile, String side) {
    if (side.equals("top")) {
      return this.top.equals(reverse(tile.bottom));
    } else if (side.equals("right")) {
      return this.right.equals(reverse(tile.left));
    } else if (side.equals("bottom")) {
      return this.bottom.equals(reverse(tile.top));
    } else if (side.equals("left")) {
      return this.left.equals(reverse(tile.right));
    }
    return false;
  }

  void addOption(Tile tile) {
    this.options.add(tile);
    this.entropy = options.size();
  }

  String reverse(String input) {
    String output = "";
    for (int i = input.length() - 1; i >= 0; i--) {
      output += input.charAt(i);
    }
    return output;
  }
}
