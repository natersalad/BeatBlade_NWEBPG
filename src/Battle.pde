class Battle {
    PImage background;
    Player player;
    Monster monster;
    SoundFile music;
    //BeatMap beatMap; // Future implementation
    
    boolean isEasyMode;
    float backgroundFade = 0; // For background fade-in effect
    
    Battle(ImageHandler images, SoundHandler sounds, Player player, boolean isEasyMode) {
        this.player = player;
        this.monster = monster;
        this.isEasyMode = isEasyMode;
        
        
        if (isEasyMode) {
            background = images.background;
            sounds.rhino.play(); //plays rhino song
            monster = new Monster("Rhino", 300, 50, images.rhino);
        } else {
            background = images.background2;
            sounds.riseOfTheDemonKing.play();  //plays demon king song
            monster = new Monster("Demon", 600, 100, images.monster);
        }
        
    }
    
    
    void update() {
        
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
        //music.play(); eliza plz fix
    }
    
    void playerAttack() {
        println("Player Attacks");
    }
    
    
    // Additional methods as necessary for battle logic, e.g., handling turns, attacks, etc.
}
