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
    
    Animation(ImageHandler images, String baseName, int frameCount, float scale) {
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
    
    void display() {
        if (isPlaying) {
            pushMatrix();
            // Calculate the scaled width and height for proper centering
            float sw = slashFrames[currentFrame].width * scale;
            float sh = slashFrames[currentFrame].height * scale;
            translate(x - sw / 2, y - sh / 2);
            scale(scale);
            
            // Display slash frame
            image(slashFrames[currentFrame], 0, 0);
            
            // Display hit frame offset if needed
            int startFrame = 1;
            switch(baseName) {
                case "slash1_":
                    offsetX = 12;
                    offsetY = 10;
                    break;
                case "slash2_":
                    offsetX = 35;
                    offsetY = 0;
                    break;
                case "slash3_":
                    offsetX = 35;
                    offsetY = 28;
                    break;
                case "slash4_":
                    offsetX = 50;
                    offsetY = 0;
                    break;
            }
            
            image(hitFrames[currentFrame], offsetX, offsetY);
            
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
