import processing.sound.*;
import java.io.File;
import java.util.HashMap;

class SoundHandler {
    PApplet parent; 
    HashMap<String, SoundFile> sounds = new HashMap<String, SoundFile>();
    
    // Constructor
    SoundHandler(PApplet p) {
        parent = p;
    }
    
    void loadSounds() {
        String path = "assets/sounds"; // The path to your sound directory
        File dir = new File(parent.sketchPath(path));
        File[] files = dir.listFiles();
        
        if (files != null) {
            for (File f : files) {
                if (f.isFile() && (f.getName().endsWith(".wav") || f.getName().endsWith(".mp3"))) {
                    SoundFile sound = new SoundFile(parent, f.getAbsolutePath());
                    sounds.put(f.getName(), sound);
                    println("Loaded sound: " + f.getName());
                } else {
                    println("Skipped file: " + f.getName());
                }
            }
        } else {
            println("No files found in directory: " + dir.getAbsolutePath());
        }
    }   
    
    SoundFile getSound(String filename) {
        return sounds.get(filename);
    }
    
}