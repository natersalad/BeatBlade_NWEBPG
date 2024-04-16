class Battle {
    PImage background;
    Player player;
    Monster monster;
    SoundFile music;
    //BeatMap beatMap; // Future implementation
    
    // Variables for slash animation
    ArrayList<Animation> animations;
    float animationX;
    float animationY;
    
    boolean isEasyMode;
    float backgroundFade = 0; // For background fade-in effect
    
    Battle(ImageHandler images, SoundHandler sounds, Player player, boolean isEasyMode) {
        this.player = player;
        this.monster = monster;
        this.isEasyMode = isEasyMode;
        
        
        if (isEasyMode) {
            background = images.getImage("Background.png");
            sounds.getSound("Rhino.wav").play(); //plays rhino song
            monster = new Monster("Rhino", 300, 50, images.getImage("Rhino.png"));
        } else {
            background = images.getImage("Background2.png");
            sounds.getSound("RiseOfTheDemonKing.wav").play();  //plays demon king song
            monster = new Monster("Demon", 600, 100, images.getImage("Monster.png"));
        }
        
        
        animations = new ArrayList<Animation>();
        animationX = width / 2; 
        animationY = height / 2; 
        loadAnimations(images);
        
    }
    
    void loadAnimations(ImageHandler images) {
        String[] animationTypes = {"slash1_", "slash2_", "slash3_", "slash4_"};
        int framesPerAnim = 4;
        
        for (String baseName : animationTypes) {
            Animation newAnim = new Animation(images, baseName, framesPerAnim, 1);
            animations.add(newAnim);
            println("Loaded Animation: " + baseName);
        }
    }   
    
    
    void update() {
        //Update animation
        for (Animation anim : animations) {
            anim.update();
        }   
        
        monster.update(millis());
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
            anim.display();
        }
    }
    
    void triggerAnimation(int index) {
        if (index >= 0 && index < animations.size()) {
            Animation anim = animations.get(index);
            anim.currentFrame = 0; 
            anim.lastUpdateTime = millis(); 
        }
    }
    
    void playerAttack() {
        println("Player attacks!");
        int animationIndex = (int) random(animations.size()); // Choose a random animation
        Animation selectedAnimation = animations.get(animationIndex);
        if (!selectedAnimation.isPlaying) { // Only start if not already playing
            selectedAnimation.start();
        }
        println("Animation Name: " + selectedAnimation.getName());
    }
    
    
    // Additional methods as necessary for battle logic, e.g., handling turns, attacks, etc.
}

