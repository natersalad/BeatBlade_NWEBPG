class Player {
    // Player sprites
    PImage spriteAttack; // Image for attack state
    PImage spriteDefend; // Image for defend state
    PImage emojiSad; // Image for sad emotion
    PImage emojiAngel; // Image for angel emotion
    PImage emojiFunny; // Image for funny emotion
    
    PFont font; // Font for displaying text
    
    // Player states and stats
    String state = "attack"; // Current state of the player
    String emotion = "none"; // Current emotion of the player
    int health = 356; // Health of the player
    int bpm = 100; // Beats per minute (could be heart rate or music tempo)
    
    // Colors
    Color colors; // Color scheme for the player
    
    // Position
    float x, y; // Current position of the player
    float targetY; // Target Y position for movement
    float moveSpeed = 0.5; // Speed of movement
    
    // Constructor
    Player(ImageHandler images, PFont font, Color colors) {
        // Load images
        spriteAttack = images.getImage("PlayerAttack.png");
        spriteDefend = images.getImage("PlayerDefend.png");
        emojiSad = images.getImage("QuitEmoji.png");    
        emojiAngel = images.getImage("EasyEmoji.png");    
        emojiFunny = images.getImage("HardEmoji.png");
        
        // Set initial player position
        x = width / 2;
        y = height / 2;
        this.targetY = height / 2;
        
        // Set colors and font
        this.colors = colors;
        this.font = font;
        textFont(font);
    }
    
    // Display the player
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
    
    // Set the player's emotion
    void setEmotion(String newEmotion) {
        emotion = newEmotion;
    }
    
    // Move the player up
    void moveUp() {
        this.targetY = baseHeight / 2;
    }
    
    // Move the player down
    void moveDown() {
        this.targetY = baseHeight * 0.80;
    }
    
    // Update the player's position
    void update() {
        float dy = targetY - y;
        
        // If the player is close enough to the target position, snap to it
        if (abs(dy) < moveSpeed) {
            y = targetY; 
        } else {
            // Otherwise, move towards the target position
            y += moveSpeed * (dy > 0 ? 1 : - 1); 
        }
    }
    
    // Reduce the player's health by a certain amount
    void takeDamage(int dmg) {
        health -= dmg;
        emotion = dmg > 100 ? "sad" : "none";
    }
    
    // Deal damage to an enemy
    void dealDamage(int dmg) {
        emotion = dmg > 200 ? "funny" : "none";
    }
    
    // Add any additional functionality needed for the Player class
}