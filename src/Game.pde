ImageHandler images;
SoundHandler sounds;
Color colors;
Player player;
PFont font;
Menu menu;

final int MENU = 0, GAMEPLAY = 1, PAUSE = 2, GAMEOVER = 3;
int gameState = MENU;
int hoveredOption = -1;

boolean isResizable = true;
float baseWidth = 288, baseHeight = 224, scaleFactor;

void setup() {
    background(0);
    size(288, 224);
    noSmooth(); 
    surface.setResizable(isResizable);
    
    font = createFont("assets/fonts/treebyfivemodifi.ttf", 32);
    textFont(font);
    
    images = new ImageHandler();
    images.loadImages();
    
    sounds = new SoundHandler(this);
    sounds.loadSounds();
    
    colors = new Color();
    player = new Player(images, font, colors);
    menu = new Menu(colors, font, player);
    surface.setSize(288 * 3, 224 * 3);
}

void draw() {
    updateScaleFactor();
    
    translate((width - baseWidth * scaleFactor) / 2,(height - baseHeight * scaleFactor) / 2);
    scale(scaleFactor);
    
    switch(gameState) {
        case MENU:
            menu.updateHoveredOption(adjustedMouseX(), adjustedMouseY());
            menu.display();
            break;
        case GAMEPLAY:
            break;
        case PAUSE:
            break;
        case GAMEOVER:
            break;
    }
    player.display();
    
    resetMatrix();
}

void updateScaleFactor() {
    scaleFactor = min(width / baseWidth, height / baseHeight);
}

float adjustedMouseX() {
    float scaleX = width / baseWidth;
    float scaleY = height / baseHeight;
    float scaleFactor = min(scaleX, scaleY);
    return(mouseX - (width - baseWidth * scaleFactor) / 2) / scaleFactor;
}

float adjustedMouseY() {
    float scaleX = width / baseWidth;
    float scaleY = height / baseHeight;
    float scaleFactor = min(scaleX, scaleY);
    return(mouseY - (height - baseHeight * scaleFactor) / 2) / scaleFactor;
}

void mousePressed() {
    menu.handleClick();
}

