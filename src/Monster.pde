class Monster {
    PImage sprite; // Monster's sprite
    PImage beatSprite; // Monster's sprite when it's on beat
    PFont font; // Font for the damage text
    BeatMap beatMap;
    String name; // Monster's name
    int health; // Current health
    int maxHealth; // Maximum health
    int attackDamage; // Damage that the monster can inflict
    SoundFile music; // The music that the monster is associated with
    
    
    float originalY; // The monster's original Y position
    Float originalX; // The monster's original X position
    float bounceHeight = 5; // How high the monster bounces
    float currentBounceY = 0; // Current bounce offset
    float currentBounceX = 0; // Current bounce offset
    float x;
    float y;
    boolean monsterTurn = false;
    boolean up = true;
    
    float lastBeatTime;
    int currentBeatIndex;
    float currentBounce;
    float beatInterval;
    SoundFile deathSound; // The death sound
    float deathFade; // The opacity of the monster when it's dying
    
    String damageText; // The damage text
    PVector damageTextPosition; // The position of the damage text
    PVector damageTextVelocity; // The velocity of the damage text
    float damageTextOpacity; // The opacity of the damage text
    boolean dead;
    
    
    // Constructor
    Monster(String name, int maxHealth, int attackDamage, PImage sprite, BeatMap beatMap, PFont font, SoundFile music) {
        this.name = name;
        this.maxHealth = maxHealth;
        this.health = maxHealth; 
        this.attackDamage = attackDamage;
        this.sprite = sprite; 
        this.beatMap = beatMap;
        this.font = font;
        this.music = music;
        
        beatSprite = sprite; // Default to the same sprite
        
        x = baseWidth / 2;
        y = baseHeight / 2;
        originalY = y;
        originalX = x;
        
        lastBeatTime = 0; // Reset the last beat time
        currentBeatIndex = 0; // Reset the current beat index
        currentBounce = 0; // Reset the current bounce
        
        this.deathSound = sounds.getSound("EnemyDeath.wav");
        this.deathFade = 255; // Fully opaque
        dead = false;
    }
    
    void update(float elapsedTime) {
        if (isDefeated() && deathFade > 0) {
            if (deathFade == 255) {
                music.stop();
                deathSound.play();
            }
            deathFade -= 1.5; // Adjust as needed
            
            if (deathFade <= 0) {
                dead = true; 
            }
        } else {
            if (monsterTurn) {
                monsterAttackAnimation(elapsedTime, 1000);
                if (!isAnimating()) {
                    lastBeatTime = millis(); // Reset the last beat time to recalibrate the bounce with the beat
                }
            } else if (!isAnimating()) {
                float bpm;
                if (name.equals("Demon")) {
                    bpm = 48;
                } else {
                    bpm = 54;
                }
                
                // Calculate the beat interval based on the BPM
                float beatInterval = 60000 / bpm;
                
                // Calculate the time since the last beat
                float timeSinceLastBeat = millis() - lastBeatTime;
                
                // Calculate the progress within the beat interval
                float beatProgress = timeSinceLastBeat / beatInterval;
                
                // Calculate the current bounce using a sinusoidal function for smoother oscillation
                currentBounce = bounceHeight * sin(TWO_PI * beatProgress);
                
                // Check if a new beat has occurred
                if (timeSinceLastBeat >= beatInterval) {
                    lastBeatTime = millis();
                    currentBeatIndex++;
                }
            }
            
            currentBounceX = 0;   
            
            if (damageText != null) {
                damageTextPosition.add(damageTextVelocity);
                damageTextOpacity -= 3; // Adjust as needed
                if (damageTextOpacity <= 0) {
                    damageText = null; // Remove the damage text
                }
            }
        }
        
    }
    
    void display() {
        imageMode(CENTER);
        tint(255, deathFade);
        
        if (beatMap.isOnBeat()) {
            if (name.equals("Demon")) {
                tint(colors.red, deathFade); // Apply a red tint
            } else {
                tint(colors.green, deathFade); // Apply a green tint
            }
            image(beatSprite, x, originalY - currentBounce);
            noTint(); // Remove the tint for subsequent images
        } else {
            image(sprite, x, originalY - currentBounce);
        }
        
        noTint();
        imageMode(CORNER);
        
        noStroke();
        
        if (damageText != null && isDefeated() == false) {
            textFont(font);
            textSize(20);
            fill(colors.red, damageTextOpacity); // Red color
            text(damageText, damageTextPosition.x, damageTextPosition.y);
        }
        
        // Additional graphics like health bar can be added here
    }
    
    void showDamage(int amount) {
        damageText = "-" + amount;
        damageTextPosition = new PVector(x, y);
        damageTextVelocity = new PVector(0, -1); // Move up
        damageTextOpacity = 255; // Fully opaque
    }
    
    // Inflict damage to the player
    int dealDamage() {
        int damageVariation = (int)random( -30, 31); // Range from -50 to 50, including both
        int damageDealt = max(attackDamage + damageVariation, 10); // deal at min 10 damage
        
        return damageDealt;
    }
    
    // Receive damage from an attack
    void takeDamage(int amount) {
        health -= amount;
        health = constrain(health, 0, maxHealth); // Ensure health doesn't drop below 0 or above max
        showDamage(amount); // Show the damage text
    }
    
    // Check if the monster is defeated
    boolean isDefeated() {
        return health <= 0;
    }
    
    void monsterAttackAnimation(float elapsedTime, float beatInterval) {
        
        
        currentBounceX = sin(TWO_PI * (elapsedTime % beatInterval) / beatInterval) * bounceHeight;
        currentBounceY = 0;
        
        // Storethe original x position before the animation starts
        if (monsterTurn && originalX == null) {
            originalX = x;
        }
        
        // Update the x position
        x = originalX + currentBounceX;
        
        if (up) {
            if (originalY <= y) {
                originalY -= 0.4;
                originalY = constrain(originalY, 50, y);
            }
            if (originalY > y) {
                originalY -= 1;
                originalY = constrain(originalY, y, y + 25);
                if (Math.abs(originalY - y) <= 0.5) { // Check if originalY is close enough to y
                    monsterTurn = false;
                    originalY -= 1;
                }
            }
        }
        else{
            if (originalY != y) {
                originalY += 3;
                originalY = constrain(originalY, 50, y + 25);
            }
            if (originalY == (y + 25)) {
                up = true;
            }
        }
        if (originalY == 50) {
            up = false;
        }
        
        // Resetthe x position after the animation
        if (!monsterTurn) {
            x = originalX;
            originalX = null;
        }
    }
    
    boolean isAnimating() {
        return monsterTurn;
    }
    
    // Additional methods for monster behavior (e.g., special attacks) can be added here
}
