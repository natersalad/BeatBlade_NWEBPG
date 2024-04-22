class Player {
    // Player sprites
    PImage spriteAttack; // Image for attack state
    PImage spriteDefend; // Image for defend state
    PImage emojiSad; // Image for sad emotion
    PImage emojiAngel; // Image for angel emotion
    PImage emojiFunny; // Image for funny emotion
    
    PFont font; // Font for displaying text
    
    SoundFile deathSound; // The death sound
    float deathFade; // The opacity of the player when it's dying
    boolean dead;
    
    // Player states and stats
    String state = "attack"; // Current state of the player
    String emotion = "none"; // Current emotion of the player
    int maxHealth = 356; // Health of the player 356
    int health = maxHealth; // Current health of the player
    int bpm = 100; // Beats per minute (could be heart rate or music tempo)
    
    // Colors
    Color colors; // Color scheme for the player
    
    // Position
    float x, y; // Current position of the player
    float targetY; // Target Y position for movement
    float moveSpeed = 0.5; // Speed of movement
    float shakeMagnitude = 5;
    boolean shake = false;
    
    
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
        
        this.deathSound = sounds.getSound("PlayerDeath.wav");
        this.deathFade = 255; // Fully opaque
        dead = false;
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
        
        if (health <= 0 && deathFade > 0) {
            setEmotion("sad");
            if (deathFade == 255) {
                sounds.getSound("Rhino.wav").stop();
                sounds.getSound("RiseOfTheDemonKing.wav").stop();
                sounds.getSound("testsong.mp3").stop();
                deathSound.play();
            }
            deathFade -= 1.5; // Adjust as needed
            
            if (deathFade <= 0) {
                dead = true; 
            }
        }
    }
    
    // Display the player
    void display() {
        // Set image mode to CENTER for drawing images centered at (x, y)
        imageMode(CENTER);
        
        if (shake) {
            x += random( -shakeMagnitude, shakeMagnitude);
            if (y == 179) {
                shake = false;
                attack();
                x = 144;
            }
        }
        
        // Display player sprite based on state
        PImage currentSprite = state.equals("attack") ? spriteAttack : state.equals("defend") ? spriteDefend : null;
        if (currentSprite != null) {
            tint(255, deathFade);
            image(currentSprite, x, y);
            noTint();
        }
        
        // Display emoji based on current emotion
        PImage currentEmoji = emotion.equals("sad") ? emojiSad : emotion.equals("angel") ? emojiAngel : emotion.equals("funny") ? emojiFunny : null;
        if (currentEmoji != null) {
            tint(255, deathFade);
            image(currentEmoji, x, y - currentSprite.height / 5 - currentEmoji.height / 5);
            noTint();
        }
        
        // Set image mode back to CORNER after drawing
        imageMode(CORNER);
        
        // Display health and BPM
        textSize(10);
        textAlign(CENTER, CENTER);
        fill(colors.white, deathFade);
        text(health, x + 20, y + 6);
        fill(colors.gray, deathFade);
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
    
    
    
    // Reduce the player's health by a certain amount
    void takeDamage(int dmg) {
        health -= dmg;
        health = constrain(health, 0, maxHealth);
    }
    
    // Check if the player is defeated
    boolean isDefeated() {
        return health <= 0;
    }
    
    // Deal damage to an enemy
    int dealDamage() {
        int damage = (int) random(5, 31);
        return damage;
    }
    
    void restoreHealth() {
        attack();
        deathFade = 255;
        health = maxHealth;
        dead = false;
    }
    
    void defend() {
        this.state = "defend";
        this.targetY = y + 15;
    }
    
    void attack() {
        this.state = "attack";
    }
    
    void setBPM(int newBPM) {
        bpm = newBPM;
    }
    
    // Add any additional functionality needed for the Player class
}