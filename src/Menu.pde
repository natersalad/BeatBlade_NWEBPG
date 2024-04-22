class Menu {
    PFont menuFont; // Font for the menu
    Color colors; // Color scheme for the menu
    int hoveredOption = -1; // Index of the currently hovered option (-1 if none)
    String[] options = {"EASY", "HARD", "QUIT"}; // Menu options
    float baseWidth = 288, baseHeight = 224; // Base dimensions for the menu
    float[] optionXs = new float[]{baseWidth / 4, baseWidth / 2, 3 * baseWidth / 4}; // X positions for the options
    Player player; // Player instance
    Battle battle; // Battle instance
    
    // Constructor
    Menu(Color colors, PFont menuFont, Player player) {
        this.colors = colors;
        this.menuFont = menuFont;
        this.player = player;
    }
    
    // Display the menu
    void display() {
        textFont(menuFont);
        background(colors.black);
        fill(colors.red);
        
        // Display title
        textSize(32);
        textAlign(CENTER, CENTER);
        text("BEATBLADE", baseWidth / 2, baseHeight / 6);
        
        // Display options
        textSize(16);
        float buttonY = 5 * baseHeight / 6;
        // Update and display options
        updateHoveredOption(adjustedMouseX(), adjustedMouseY());
        for (int i = 0; i < options.length; i++) {
            // Draw white rectangle behind the text if the button is hovered
            float textW = textWidth(options[i]);
            float textH = 20; 
            
            float rectStartX = optionXs[i] - (textW / 2) - 3;
            float rectEndX = optionXs[i] + (textW / 2) + 1;
            float rectStartY = buttonY - (textH / 2) - 3;
            float rectEndY = buttonY + (textH / 2) + 3;
            
            if (i == hoveredOption) {
                fill(colors.white);
                rectMode(CORNERS);
                rect(rectStartX, rectStartY, rectEndX, rectEndY);
            }
            
            fill(colors.red);
            text(options[i], optionXs[i], buttonY);
        }
    }
    
    // Update the currently hovered option based on the mouse position
    void updateHoveredOption(float mouseXAdjusted, float mouseYAdjusted) {
        float buttonY = 5 * baseHeight / 6;
        hoveredOption = -1;
        for (int i = 0; i < options.length; i++) {
            float optionWidth = textWidth(options[i]);
            if (mouseXAdjusted >= optionXs[i] - optionWidth / 2 && mouseXAdjusted <= optionXs[i] + optionWidth / 2 && 
                mouseYAdjusted >= buttonY - 10 && mouseYAdjusted <= buttonY + 10) {
                hoveredOption = i;
                break;
            }
        }
        
        // Update player's emotion based on the hovered option
        if (hoveredOption == 0) { // EASY button
            player.setEmotion("angel");
        } else if (hoveredOption == 1) { // HARD button
            player.setEmotion("funny");
        } else if (hoveredOption == 2) { // QUIT button
            player.setEmotion("sad");
        } else {
            player.setEmotion("none");
        }
    }
    
    // Handle click events
    void handleClick() {
        // Ensure a valid option is hovered before proceeding
        if (hoveredOption == -1) {
            return;
        }
        
        // Perform action based on the hovered option
        switch(hoveredOption) {
            case 0 : // EASY
                player.setEmotion("none");
                sounds.getSound("MenuMove.mp3").play();
                battle = new Battle(images, sounds, player, menuFont, true);
                startBattleTransition(battle);
                break;
            case 1 : // HARD
                player.setEmotion("none");
                sounds.getSound("MenuMove.mp3").play();
                battle = new Battle(images, sounds, player, menuFont, false);
                startBattleTransition(battle);
                break;
            case 2 : // QUIT
                sounds.getSound("MenuMove.mp3").play();
                exit();
        }
    }
}