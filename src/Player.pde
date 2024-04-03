class Player {
    // Player sprites
    PImage spriteAttack;
    PImage spriteDefend;
    PImage emojiSad;
    PImage emojiAngel;
    PImage emojiFunny;
    
    PFont font;
    
    // Player states and stats
    String state = "attack";
    String emotion = "none";
    int health = 356;
    int bpm = 100;
    
    // Colors
    Color colors;
    
    // Position
    float x, y;
    float menuY; 
    float battleY; 
    
    Player(ImageHandler images, PFont font, Color colors) {
        spriteAttack = images.playerAttack;
        spriteDefend = images.playerDefend;
        emojiSad = images.quitEmoji;    
        emojiAngel = images.easyEmoji;    
        emojiFunny = images.hardEmoji;
        
        // Initial player position
        x = width / 2;
        menuY = y = height / 2;
        
        this.colors = colors;
        
        this.font = font;
        textFont(font);
    }
    
    void display() {
        // Set image mode to CENTER for drawing images centered at (x, y)
        imageMode(CENTER);
        
        // Display player sprite based on state
        PImage currentSprite = state.equals("attack") ? spriteAttack : state.equals("defend") ? spriteDefend : null;
        if (currentSprite != null) {
            image(currentSprite, x, y);
        }
        
        // Display emoji based on current emotion
        PImage currentEmoji = emotion.equals("sad") ? emojiSad : emotion.equals("angel") ? emojiAngel : emotion.equals("funny") ? emojiFunny : null;
        if (currentEmoji != null) {
            image(currentEmoji, x, y - currentSprite.height / 5 - currentEmoji.height / 5);
        }
        
        // Set image mode back to CORNER after drawing
        imageMode(CORNER);
        
        // Display health and BPM
        textSize(10);
        textAlign(CENTER, CENTER);
        fill(colors.white);
        text(health, x + 20, y + 6);
        fill(colors.gray);
        text(bpm, x + 18, y + 17);
    }
    
    void setEmotion(String newEmotion) {
        emotion = newEmotion;
    }
    
    void update() {
        if (y != battleY) {
            y = lerp(y, battleY, 0.05); 
        }
    }
    
    void moveToBottom() {
        battleY = height - spriteAttack.height;
    }
    
    void moveToMiddle() {
        battleY = menuY;
    }
    
    void takeDamage(int dmg) {
        health -= dmg;
        emotion = dmg > 100 ? "sad" : "none";
    }
    
    void dealDamage(int dmg) {
        emotion = dmg > 200 ? "funny" : "none";
    }
    
    // Add any additional functionality needed for the Player class
}
