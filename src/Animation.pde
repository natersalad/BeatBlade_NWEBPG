class Animation {
    PImage[] slashFrames; // Frames for the slash animation
    PImage[] hitFrames;  // Frames for the corresponding hit effects
    int currentFrame;
    float animationRate;
    float lastUpdateTime;
    float x, y;
    float scale;
    float offsetX, offsetY; 
    String baseName;
    boolean isPlaying;
    boolean hasCompletedOnce;
    float baseWidth = 288, baseHeight = 224; // Base dimensions
    BeatMap beatMap;
    SoundHandler sounds;
    
    Animation(ImageHandler images, String baseName, int frameCount, float scale, BeatMap beatMap, SoundHandler sounds) {
        this.slashFrames = new PImage[frameCount];
        this.hitFrames = new PImage[frameCount];
        this.currentFrame = 0;
        this.animationRate = 1000 / 12; // e.g., 12 fps
        this.lastUpdateTime = millis();
        this.x = baseWidth / 2;
        this.y = baseHeight / 2;
        this.offsetX = offsetX;
        this.offsetY = offsetY;
        this.scale = scale;
        this.baseName = baseName;
        this.isPlaying = false;
        this.hasCompletedOnce = false;
        this.beatMap = beatMap;
        this.sounds = sounds;
        
        
        // Load the frames for both the slash and hit effects
        for (int i = 0; i < frameCount; i++) {
            this.slashFrames[i] = images.getImage(baseName + (i + 1) + ".png");
            this.hitFrames[i] = images.getImage("hit" + baseName.charAt(baseName.length() - 2) + "_" + (i + 1) + ".png");
        }
    }
    
    void start() {
        currentFrame = 0;
        lastUpdateTime = millis();
        isPlaying = true;
        hasCompletedOnce = false;
        
        if (beatMap.isOnBeat()) {
            
            switch(baseName) {
                case "slash1_":
                    sounds.getSound("HeavySlash1.wav").play();
                    break;
                case "slash2_":
                    sounds.getSound("HeavySlash2.wav").play();
                    break;
                case "slash3_":
                    sounds.getSound("HeavySlash3.wav").play();
                    break;
                case "slash4_":
                    sounds.getSound("HeavySlash4.wav").play();
                    break;
            }
        } else {
            switch(baseName) {
                case "slash1_":
                    sounds.getSound("WeakSlash1.wav").play();
                    break;
                case "slash2_":
                    sounds.getSound("WeakSlash2.wav").play();
                    break;
                case "slash3_":
                    sounds.getSound("WeakSlash3.wav").play();
                    break;
                case "slash4_":
                    sounds.getSound("WeakSlash1.wav").play();
                    break;
            }
        }
    }
    
    void update() {
        if (isPlaying && millis() - lastUpdateTime > animationRate) {
            lastUpdateTime = millis();
            currentFrame = (currentFrame + 1) % slashFrames.length; // Assume both arrays are the same length
            
            if (currentFrame == 0) {
                hasCompletedOnce = true;
            }
        }
        
        if (hasCompletedOnce && currentFrame == 0) {
            isPlaying = false;
        }
        
    }
    
    void display(boolean isHit) {
        if (isPlaying) {
            pushMatrix();
            // Calculate the scaled width and height for proper centering
            float sw = slashFrames[currentFrame].width * scale;
            float sh = slashFrames[currentFrame].height * scale;
            translate(x - sw / 2, y - sh / 2);
            scale(scale);
            image(slashFrames[currentFrame], 0, 0);
            if (isHit) {
                // Display hit frame offset if needed
                switch(baseName) {
                    case"slash1_":
                    offsetX = 0;
                    offsetY = 0;
                    break;
                    case"slash2_":
                    offsetX = 0;
                    offsetY = 0;
                    break;
                    case"slash3_":
                    offsetX = 10;
                    offsetY = 20;
                    break;
                    case"slash4_":
                    offsetX = 30;
                    offsetY = 0;
                    break;
                }
                image(hitFrames[currentFrame], offsetX, offsetY);
            }
            
            popMatrix();
        }
    }
    
    String getName() {
        return baseName;
    }
    
    void setPosition(float x, float y) {
        this.x = x;
        this.y = y;
    }
}
