// Main game class that runs the game loop

final int MENU = 0;
final int GAMEPLAY = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;
int gameState = Menu;

void void setup() {
    size(800, 600);
    // Initialize all game elements
    // Load all assets
    // Set up the player
}

void draw() {
    background(0);

    switch (gameState) {
        case MENU :
            displayMenu();
            break;
        case GAMEPLAY:
            //runGameplay();
            break;
        case PAUSE:
            //displayPauseMenu();
            
        case GAMEOVER:
            //displayGameOver();
            break;
    }
}
