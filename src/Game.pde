// Main game class that runs the game loop
PFont menuFont;

ImageHandler images;
SoundHandler sounds;
Color colors;

final int MENU = 0;
final int GAMEPLAY = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;
int gameState = MENU;
int hoveredOption = -1;

void setup() {
    size(800, 600);
    
    // Load Font
    menuFont = createFont("assets/fonts/treebyfivemodifi.ttf", 32);
    textFont(menuFont, 32);

    // Load the images
    images = new ImageHandler();
    images.loadImages();

    // Load the sounds
    sounds = new SoundHandler(this);
    sounds.loadSounds();

    // Load the colors
    colors = new Color();

}

void draw() {
    background(0);
    switch (gameState) {
        case MENU:
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

void displayMenu() {
    background(colors.black); 
    
    // Draw the game title
    fill(colors.red); 
    textSize(100); 
    textAlign(CENTER, CENTER);
    text("BEATBLADE", width / 2, 150); 
    float titleWidth = textWidth("BEATBLADE");

    float spacing = 60; 
    
    // Draw menu buttons
    textSize(50);
    float easyX = (width / 2) - (titleWidth / 2) + spacing; 
    float quitX = (width / 2) + (titleWidth / 2) - spacing; 
    float hardX = width / 2; 
    float[] optionXs = {easyX, hardX, quitX};
    String[] options = {"EASY", "HARD", "QUIT"};
    int hoveredOption = -1; 
    int optionY = height - 100;
    float buttonHeight = textAscent() + textDescent();

    for (int i = 0; i < options.length; i++) {
        float optionWidth = textWidth(options[i]);
        if (mouseX >= optionXs[i] - optionWidth / 2 && mouseX <= optionXs[i] + optionWidth / 2 &&
            mouseY >= optionY - buttonHeight / 2 && mouseY <= optionY + buttonHeight / 2) {
            hoveredOption = i;
        }
    }
   
    for (int i = 0; i < options.length; i++) {
        float optionX = optionXs[i];
        // Change color based on hover state
        fill(i == hoveredOption ? colors.white : colors.red);

        textAlign(CENTER, CENTER);
        text(options[i], optionX, optionY); 
    }
}



