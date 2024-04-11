// Declare game components
ImageHandler images;
SoundHandler sounds;
Color colors;
Player player;
PFont font;
Menu menu;
Battle battle;

// Define game states
final int MENU = 0, GAMEPLAY = 1, PAUSE = 2, GAMEOVER = 3, FADE_OUT = 4, FADE_IN = 5;
int gameState = MENU; // Current game state
int hoveredOption = -1; // Currently hovered menu option
int fadeOpacity = 0; // Opacity for fade transitions
int nextState = MENU; // The state to transition to after a fade

boolean isResizable = true; // Whether the game window is resizable
float baseWidth = 288, baseHeight = 224, scaleFactor; // Base dimensions and scale factor for the game window

void setup() {
    background(0);
    size(288, 224);
    noSmooth(); 
    surface.setResizable(isResizable); // Set window resizability
    surface.setTitle("Beat Blade");
    
    // Load font
    font = createFont("assets/fonts/treebyfivemodifi.ttf", 32);
    textFont(font);
    
    // Load images
    images = new ImageHandler();
    images.loadImages();
    
    // Load sounds
    sounds = new SoundHandler(this);
    sounds.loadSounds();
    
    // Initialize game components
    colors = new Color();
    player = new Player(images, font, colors);
    menu = new Menu(colors, font, player);
    surface.setSize(288 * 3, 224 * 3); // Set window size
}

void draw() {
    updateScaleFactor(); // Update scale factor for the game window
    
    // Apply transformations for scaling
    translate((width - baseWidth * scaleFactor) / 2,(height - baseHeight * scaleFactor) / 2);
    scale(scaleFactor);
    
    // Handle game states
    switch(gameState) {
        case MENU:
            menu.updateHoveredOption(adjustedMouseX(), adjustedMouseY()); // Update hovered menu option
            menu.display(); // Display menu
            break;
        case FADE_OUT:
            fadeOut(); // Handle fade out transition
            break;
        case FADE_IN:
            fadeIn(); // Handle fade in transition
            break;
        case GAMEPLAY:
            battle.display(); // Display battle
            battle.update();
            break;
        case GAMEOVER:
            break; // Handle game over state
    }
    player.update(); // Update player
    player.display(); // Display player
    
    resetMatrix(); // Reset transformation matrix
}

// Handle fade out transition
void fadeOut() {
    fill(0, fadeOpacity);
    rect(0, 0, width, height);
    fadeOpacity += 3;
    
    if (fadeOpacity >= 255) {
        fadeOpacity = 255; 
        gameState = FADE_IN; 
    }
}

// Handle fade in transition
void fadeIn() {
    if (battle != null && nextState == GAMEPLAY) {
        battle.display();
    } else {
        menu.display();
    }
    
    fill(0, fadeOpacity);
    rect(0, 0, width, height);
    fadeOpacity -= 3;
    
    if (fadeOpacity <= 0) {
        fadeOpacity = 0; 
        gameState = nextState; 
    }
}

void keyPressed() {
    if (gameState == GAMEPLAY) {
        switch(key) {
            case ESC:
                key = 0; // Neutralize default ESC functionality
                returnToMenu();
                break;
            case ENTER:
                battle.playerAttack(); 
                break;
        }
    }
}

// Return to Menu Transition
void returnToMenu() {
    player.moveUp();
    fadeOpacity = 0;
    gameState = FADE_OUT;
    nextState = MENU;
}

// Start battle transition
void startBattleTransition(Battle newBattle) {
    player.moveDown();
    this.battle = newBattle;
    fadeOpacity = 0; 
    gameState = FADE_OUT;
    nextState = GAMEPLAY; 
}

// Update scale factor for the game window
void updateScaleFactor() {
    scaleFactor = min(width / baseWidth, height / baseHeight);
}

// Adjust mouse X coordinate for scaling
float adjustedMouseX() {
    float scaleX = width / baseWidth;
    float scaleY = height / baseHeight;
    float scaleFactor = min(scaleX, scaleY);
    return(mouseX - (width - baseWidth * scaleFactor) / 2) / scaleFactor;
}

// Adjust mouse Y coordinate for scaling
float adjustedMouseY() {
    float scaleX = width / baseWidth;
    float scaleY = height / baseHeight;
    float scaleFactor = min(scaleX, scaleY);
    return(mouseY - (height - baseHeight * scaleFactor) / 2) / scaleFactor;
}

// Handle mouse press events
void mousePressed() {
    if (gameState == MENU) {
        menu.handleClick(); // Handle menu click
    }
}