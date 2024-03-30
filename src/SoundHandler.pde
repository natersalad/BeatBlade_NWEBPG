import processing.sound.*;

class SoundHandler {
    PApplet parent; 

    SoundFile enemyDeath;
    SoundFile heavySlash1;
    SoundFile heavySlash2;
    SoundFile heavySlash3;
    SoundFile heavySlash4;
    SoundFile medHit2;
    SoundFile menuMove;
    SoundFile pause;
    SoundFile playerDeath;
    SoundFile rhino;
    SoundFile riseOfTheDemonKing;
    SoundFile strongHit3;
    SoundFile weakHit1;
    SoundFile weakSlash1;
    SoundFile weakSlash2;
    SoundFile weakSlash3;

    // Constructor
    SoundHandler(PApplet p) {
        parent = p;
        loadSounds();
    }

    void loadSounds() {
        enemyDeath = new SoundFile(parent, "assets/sounds/EnemyDeath.wav");
        heavySlash1 = new SoundFile(parent, "assets/sounds/HeavySlash1.wav");
        heavySlash2 = new SoundFile(parent, "assets/sounds/HeavySlash2.wav");
        heavySlash3 = new SoundFile(parent, "assets/sounds/HeavySlash3.wav");
        heavySlash4 = new SoundFile(parent, "assets/sounds/HeavySlash4.wav");
        medHit2 = new SoundFile(parent, "assets/sounds/MedHit2.mp3");
        menuMove = new SoundFile(parent, "assets/sounds/MenuMove.mp3");
        pause = new SoundFile(parent, "assets/sounds/Pause.mp3");
        playerDeath = new SoundFile(parent, "assets/sounds/PlayerDeath.wav");
        rhino = new SoundFile(parent, "assets/sounds/Rhino.wav");
        riseOfTheDemonKing = new SoundFile(parent, "assets/sounds/RiseOfTheDemonKing.wav");
        strongHit3 = new SoundFile(parent, "assets/sounds/StrongHit3.mp3");
        weakHit1 = new SoundFile(parent, "assets/sounds/WeakHit1.mp3");
        weakSlash1 = new SoundFile(parent, "assets/sounds/WeakSlash1.wav");
        weakSlash2 = new SoundFile(parent, "assets/sounds/WeakSlash2.wav");
        weakSlash3 = new SoundFile(parent, "assets/sounds/WeakSlash3.wav");
    }
}
