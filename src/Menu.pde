class Menu {
    PFont menuFont;
    Color colors;
    int hoveredOption = -1;
    String[] options = {"EASY", "HARD", "QUIT"};
    float baseWidth = 288, baseHeight = 224; 
    float[] optionXs = new float[]{baseWidth / 4, baseWidth / 2, 3 * baseWidth / 4};
    Player player;
    
    
    Menu(Color colors, PFont menuFont, Player player) {
        this.colors = colors;
        this.menuFont = menuFont;
        this.player = player;
    }
    
    void display() {
        textFont(menuFont);
        background(colors.black);
        fill(colors.red);
        
        // Title
        textSize(32);
        textAlign(CENTER, CENTER);
        text("BEATBLADE", baseWidth / 2, baseHeight / 6);
        
        // Options
        textSize(16); 
        float buttonY = 5 * baseHeight / 6;
        // Update and display options
        updateHoveredOption(adjustedMouseX(), adjustedMouseY());
        for (int i = 0; i < options.length; i++) {
            fill(i == hoveredOption ? colors.white : colors.red);
            text(options[i], optionXs[i], buttonY);
        }
    }
    
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
    
    void handleClick() {
        // Ensure a valid option is hovered before proceeding
        if (hoveredOption == -1) {
            return;
        }
        
        switch(hoveredOption) {
            case 0 : // EASY
                println("EASY clicked");
                break;
            case 1 : // HARD
                println("HARD clicked");
                break;
            case 2 : // QUIT
                exit();
        }
    }
    
}
