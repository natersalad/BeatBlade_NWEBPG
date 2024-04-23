class Battle {
    PImage background;
    PFont font;
    Player player;
    Monster monster;
    SoundFile music;
    BeatMap beatMap;
    
    // Variables for slash animation
    ArrayList<Animation> animations;
    float animationX;
    float animationY;
    int lastAnimationIndex = -1;
    
    boolean isEasyMode;
    float backgroundFade = 0; // For background fade-in effect
    boolean playerHit = false;
    boolean playerTurn;
    
    boolean hitSoundPlayed = false; // Flag to check if the hit sound has been played
    int comboCount = 0; 
    int maxComboCount = 0;
    
    boolean gameOver = false;
    float gameOverFade;
    
    
    Battle(ImageHandler images, SoundHandler sounds, Player player, PFont font, boolean isEasyMode) {
        this.player = player;
        this.monster = monster;
        this.isEasyMode = isEasyMode;
        this.font = font;
        playerTurn = true;
        
        if (isEasyMode) {
            player.setBPM(108);
            background = images.getImage("Background.png");
            music = sounds.getSound("Rhino.wav");
            music.play();
            this.beatMap = new BeatMap("assets/RhinoBeatMap.MID", 200, 0);
            monster = new Monster("Rhino", 500, 50, images.getImage("Rhino.png"), this.beatMap, font, music);
        } else {
            player.setBPM(96);
            background = images.getImage("Background2.png");
            music = sounds.getSound("RiseOfTheDemonKing.wav");
            this.beatMap = new BeatMap("assets/DemonBeatMap.MID", 130, 0);
            music.play();
            //this.beatMap = new BeatMap("/Percussion.mid", 200);
            monster = new Monster("Demon", 2500, 75, images.getImage("Monster.png"), this.beatMap, font, music);
        }
        
        
        animations = new ArrayList<Animation>();
        animationX = width / 2; 
        animationY = height / 2; 
        loadAnimations(images);
        
    }
    
    void switchTurn() {
        if (playerTurn) {
            player.defend();
            monster.monsterTurn = true;
            playerTurn = false;
        } else {
            player.attack();
            playerTurn = true;
        }
    }
    
    boolean isGameOver() {
        // The game is over if the player or the monster is defeated
        return player.dead == true || monster.dead == true || isSongOver();
    }
    
    boolean isSongOver() {
        // Calculate the current time relative to the start time
        float currentTime = music.position();
        
        // The song is over if the current time is greater than the length of the song
        return currentTime >= music.duration();
    }
    
    void loadAnimations(ImageHandler images) {
        String[] animationTypes = {"slash1_", "slash2_", "slash3_", "slash4_"};
        int framesPerAnim = 4;
        
        for (String baseName : animationTypes) {
            Animation newAnim = new Animation(images, baseName, framesPerAnim, 1, beatMap, sounds);
            animations.add(newAnim);
            println("Loaded Animation: " + baseName);
        }
    }
    
    void update() {

        if (comboCount > maxComboCount) {
            maxComboCount = comboCount;
        }
        
        if (isGameOver()) {
            comboCount = 0; // Reset the combo count
            gameOver = true;
            playerTurn = false;
            monster.monsterTurn = false;
        }
        
        if (gameOver && gameOverFade < 255) {
            gameOverFade += 3; 
        }
        
        checkMonsterPositionAndShakePlayer();
        
        for (Animation anim : animations) {
            anim.update();
        }
        
        if (isSongOver()) {
            println("Song is over!");
        }   
        
        monster.update(millis());
        
        if (!playerTurn && !monster.isAnimating() && gameOver == false) {
            switchTurn();
        }
        
    }
    
    void display() {
        if (isEasyMode) {
            background(colors.black);
        } else {
            background(#531b1b);
        }
        image(background, 0, 0);
        monster.display();
        //Display animation
        for (Animation anim : animations) {
            anim.display(playerHit);
        }
        
        if (gameOver) {
            if (player.isDefeated() || isSongOver()) {
                player.setEmotion("sad");
                displayLoss();
            } else if (monster.isDefeated()) {
                player.setEmotion("angel");
                displayWin();
            } 
        }
        
        // Display combo count
        if (comboCount >= 1) { // Only display when combo count is at least 1
            textFont(font); // Use your specified font
            fill(colors.white);
            textSize(16);
            textAlign(CENTER, CENTER); // Center the text
            text("COMBO", baseWidth / 2, baseHeight / 10); // Adjust the position as needed
            text(comboCount, baseWidth / 2, baseHeight / 5); // Adjust the position as needed
            if (comboCount == 10) {
                player.setEmotion("angel");
            }
            if (comboCount == 30) {
                player.setEmotion("funny");
            }
        }
        else if (comboCount == 0) {
            player.setEmotion("none");
        }
    }
    
    void displayWin() {
        fill(colors.green, gameOverFade);
        textSize(42);
        textAlign(CENTER, CENTER);
        text("YOU WIN!", baseWidth / 2, baseHeight / 2);

        fill(colors.white, gameOverFade);
        textSize(16);
        textAlign(CENTER, CENTER); // Center the text
        text("MAX COMBO", baseWidth / 2, baseHeight / 10); // Adjust the position as needed
        text(maxComboCount, baseWidth / 2, baseHeight / 5); // Adjust the position as needed
    }
    
    void displayLoss() {
        if (isEasyMode) {
            fill(colors.red, gameOverFade);
        } else {
            fill(colors.cyan, gameOverFade);
        }
        textSize(42);
        textAlign(CENTER, CENTER);
        text("YOU LOSE!", baseWidth / 2, baseHeight / 2);
    }
    
    void playerAttack() {
        // Only allow the player to attack if it's their turn
        if (playerTurn) {
            int animationIndex = lastAnimationIndex;
            
            // Ensure a new animation is selected if more than one is available
            while(animations.size() > 1 && animationIndex == lastAnimationIndex) {
                animationIndex = (int) random(animations.size()); // Choose a random animation index
            }
            
            lastAnimationIndex = animationIndex; // Update last animation index
            Animation selectedAnimation = animations.get(animationIndex);
            
            if (!selectedAnimation.isPlaying) { // Only start if not already playing
                selectedAnimation.start();
            }
            
            if (beatMap.isOnBeat()) {
                comboCount++; // Increase the combo count
                playerHit = true;
                monster.takeDamage(player.dealDamage());
                
            } else {
                playerHit = false;
                comboCount = 0; // Reset the combo count
                // Switch turns if the player misses
                switchTurn();
            }
        }
    }
    
    BeatMap getBeatMap() {
        return this.beatMap;
    }
    
    void checkMonsterPositionAndShakePlayer() {
        if (monster.originalY <= (monster.y + 25) && monster.originalY > (monster.y) && monster.up == true) {
            player.targetY = 179;
            if (player.y > 179 && !hitSoundPlayed) { // Check the flag here
                player.shake = true;
                player.takeDamage(monster.dealDamage());
                String[] hitSounds = {"Hit1.mp3", "Hit2.mp3", "Hit3.mp3"};
                String randomHitSound = hitSounds[(int) random(hitSounds.length)];
                sounds.getSound(randomHitSound).play();
                hitSoundPlayed = true; // Set the flag to true after playing the sound
            }
        } else {
            hitSoundPlayed = false; // Reset the flag when the condition is not met
        }
    }
    // Additional methods as necessary for battle logic, e.g., handling turns, attacks, etc.
}

