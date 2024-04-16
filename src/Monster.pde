class Monster {
    PImage sprite; // Monster's sprite
    String name; // Monster's name
    int health; // Current health
    int maxHealth; // Maximum health
    int attackDamage; // Damage that the monster can inflict
    
    float originalY; // The monster's original Y position
    float bounceHeight = 2; // How high the monster bounces
    float currentBounce = 0; // Current bounce offset
    float x;
    float y;
    
    // Constructor
    Monster(String name, int maxHealth, int attackDamage, PImage sprite) {
        this.name = name;
        this.maxHealth = maxHealth;
        this.health = maxHealth; 
        this.attackDamage = attackDamage;
        this.sprite = sprite; 
        
        x = baseWidth / 2;
        y = baseHeight / 2;
        originalY = y;
    }
    
    void update(float elapsedTime) {
        float beatInterval = 1000; 
        
        currentBounce = sin(TWO_PI * (elapsedTime % beatInterval) / beatInterval) * bounceHeight;
    }
    
    void display() {
        imageMode(CENTER);
        image(sprite, x, originalY - currentBounce);
        imageMode(CORNER);
        
        // Additional graphics like health bar can be added here
    }
    
    // Monster's behavior during its turn, can be expanded with more complex AI
    void takeTurn(Player player) {
        attack(player);
    }
    
    // Inflict damage to the player
    void attack(Player player) {
        int damageVariation = (int)random( -50, 51); // Range from -50 to 50, including both
        int damageDealt = max(attackDamage + damageVariation, 10); // deal at min 10 damage
        
        player.takeDamage(damageDealt);
        println(name + " attacks for " + damageDealt + " damage!");
    }
    
    // Receive damage from an attack
    void takeDamage(int amount) {
        health -= amount;
        health = constrain(health, 0, maxHealth); // Ensure health doesn't drop below 0 or above max
    }
    
    // Check if the monster is defeated
    boolean isDefeated() {
        return health <= 0;
    }
    
    // Additional methods for monster behavior (e.g., special attacks) can be added here
}
