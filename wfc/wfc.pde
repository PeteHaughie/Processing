/**
 * This code implements the Wave Function Collapse (WFC) algorithm in Processing.
 * The algorithm generates a grid of tiles by collapsing each cell based on the constraints
 * imposed by its neighboring cells. The goal is to create a valid grid that satisfies
 * the given set of tile patterns.
 *
 * The code defines various parameters such as the dimensions of the tiles, the grid size,
 * the number of tiles to process per batch, the maximum number of restarts allowed, and
 * the maximum additional passes to resolve contradictions.
 *
 * The code also includes functions to load the tile patterns and images, initialize the grid,
 * draw the grid, check if the grid is fully collapsed, reverse a string, collapse the next cell,
 * update the options of neighboring cells, validate the grid, validate a specific cell, and
 * validate a neighboring cell.
 *
 * The Tile class represents a tile with its sides, collapsed state, options, tile index, and entropy.
 * The collapse method collapses the tile by setting its sides, tile index, collapsed state, and entropy.
 * The display method displays the tile image if it is collapsed and has a valid tile index.
 * The matches method checks if the tile matches another tile on a specific side.
 * The addOption method adds a tile as a possible option for the current tile.
 */
int DIM = 5; // the width and height of the tiles
int gridWidth, gridHeight = 0;
int batchSize = 1; // number of tiles to process per batch
int maxRestarts = 100; // maximum number of restarts allowed
int restartCount = 0; // counter for the number of restarts
int maxAttempts = 10; // maximum additional passes to resolve contradictions

PImage[] img = new PImage[12]; // array of tiles
Tile[][] grid;
ArrayList<Tile> tiles = new ArrayList<Tile>();

void setup() {
  size(1000, 1000);
  // fullScreen();
  gridWidth = width / DIM;
  gridHeight = height / DIM;
  batchSize = height / DIM;
  loadTiles();
  loadImages();
  initialiseGrid();
  loop(); // Start the draw loop to begin collapsing
}

void draw() {
  background(255); // Clear the screen before drawing the grid
  
  drawGrid();
  
  int iterations = 0;
  boolean contradiction = false;
  
  while (iterations < batchSize && !contradiction) {
    contradiction = !collapseNextCell();
    iterations++;
  }

  if (isCollapsed() && !contradiction) {
    if (resolveUnfilledCells()) {
      drawGrid(); // give it a kick in the arse
      saveFrame(second() + "-" + minute() + "-" + hour() + "-" + month() + "-" + year() + ".png");
      noLoop(); // Stop when fully collapsed and validated
    }
  } else if (contradiction) {
    boolean resolved = false;
    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      contradiction = false;
      iterations = 0;
      while (iterations < batchSize && !contradiction) {
        contradiction = !collapseNextCell();
        iterations++;
      }
      if (!contradiction) {
        resolved = true;
        break;
      }
    }
    if (!resolved) {
      restartCount++;
      if (restartCount >= maxRestarts) {
        println("Maximum restarts reached. Unable to generate a valid grid.");
        noLoop(); // Stop the algorithm after reaching the maximum number of restarts
      } else {
        initialiseGrid(); // Restart if a contradiction is found
      }
    }
  }
}

void loadTiles() {
  // Define tiles with their sides and indices
  tiles.add(new Tile("00000", "00000", "00000", "00000", 0));
  tiles.add(new Tile("00000", "00100", "00000", "00100", 1));
  tiles.add(new Tile("00100", "00000", "00100", "00000", 2));
  tiles.add(new Tile("00100", "00100", "00100", "00100", 3));
  tiles.add(new Tile("00100", "00000", "00000", "00100", 4));
  tiles.add(new Tile("00100", "00100", "00000", "00000", 5));
  tiles.add(new Tile("00000", "00100", "00100", "00000", 6));
  tiles.add(new Tile("00000", "00000", "00100", "00100", 7));
  tiles.add(new Tile("00000", "00100", "00100", "00100", 8));
  tiles.add(new Tile("00100", "00100", "00000", "00100", 9));
  tiles.add(new Tile("00100", "00000", "00100", "00100", 10));
  tiles.add(new Tile("00100", "00100", "00100", "00000", 11));
}

void loadImages() {
  // Load images into the array for use in the grid
  for (int i = 0; i < 12; i++) {
    img[i] = loadImage(i + ".tiff");
    if (img[i] == null) {
      println("Image " + i + " failed to load.");
    }
  }
}

void initialiseGrid() {
  // Initialize the grid with possible options
  grid = new Tile[gridWidth][gridHeight];
  for (int x = 0; x < gridWidth; x++) {
    for (int y = 0; y < gridHeight; y++) {
      grid[x][y] = new Tile(); // Ensure every grid cell is initialized
      for (Tile t : tiles) {
        grid[x][y].addOption(t); // Add all tiles as possible options initially
      }
    }
  }
}

void drawGrid() {
  for (int x = 0; x < gridWidth; x++) {
    for (int y = 0; y < gridHeight; y++) {
      grid[x][y].display(x * DIM, y * DIM);
    }
  }
}

boolean isCollapsed() {
  for (int x = 0; x < gridWidth; x++) {
    for (int y = 0; y < gridHeight; y++) {
      if (!grid[x][y].isCollapsed()) {
        return false;
      }
    }
  }
  return true;
}

boolean collapseNextCell() {
  int minEntropy = Integer.MAX_VALUE;
  int minX = -1;
  int minY = -1;

  for (int x = 0; x < gridWidth; x++) {
    for (int y = 0; y < gridHeight; y++) {
      Tile cell = grid[x][y];
      if (!cell.isCollapsed() && cell.entropy < minEntropy && cell.entropy > 0) {
        minEntropy = cell.entropy;
        minX = x;
        minY = y;
      }
    }
  }

  if (minX == -1 || minY == -1) return false;

  Tile selectedCell = grid[minX][minY];
  if (selectedCell.options.size() == 0) {
    println("Contradiction found at " + minX + ", " + minY);
    return false;
  }

  Tile chosenTile = selectedCell.options.get((int) random(selectedCell.options.size()));
  selectedCell.collapse(chosenTile);

  // Propagate constraints to neighbors
  updateNeighbors(minX, minY);
  return true;
}

void updateNeighbors(int x, int y) {
  Tile cell = grid[x][y];

  updateOptions(x, (y - 1 + gridHeight) % gridHeight, cell, "top");
  updateOptions((x + 1) % gridWidth, y, cell, "right");
  updateOptions(x, (y + 1) % gridHeight, cell, "bottom");
  updateOptions((x - 1 + gridWidth) % gridWidth, y, cell, "left");
}

void updateOptions(int x, int y, Tile sourceTile, String side) {
  Tile cell = grid[x][y];

  if (!cell.isCollapsed()) {
    ArrayList<Tile> newOptions = new ArrayList<Tile>();

    for (Tile option : cell.options) {
      if (sourceTile.matches(option, side)) {
        newOptions.add(option);
      }
    }

    if (newOptions.size() > 0) {
      cell.options = newOptions;
      cell.entropy = newOptions.size();
    } else {
      println("No valid options for cell at " + x + ", " + y);
      cell.options.clear(); // Clear options to indicate contradiction
    }
  }
}

boolean resolveUnfilledCells() {
  boolean progress = true;
  for (int attempt = 0; attempt < maxAttempts; attempt++) {
    progress = false;
    for (int x = 0; x < gridWidth; x++) {
      for (int y = 0; y < gridHeight; y++) {
        Tile cell = grid[x][y];
        if (!cell.isCollapsed() && cell.options.size() > 0) {
          Tile chosenTile = cell.options.get((int) random(cell.options.size()));
          cell.collapse(chosenTile);
          updateNeighbors(x, y);
          progress = true;
        }
      }
    }
    if (isCollapsed()) {
      return true;
    }
    if (!progress) {
      break;
    }
  }
  return false;
}
