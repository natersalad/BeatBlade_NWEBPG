import java.io.File;
import java.util.HashMap;

class ImageHandler {
    HashMap<String, PImage> images = new HashMap<String, PImage>();
    
    void loadImages() {
        String path = "assets/images"; // The path to your image directory
        File dir = new File(sketchPath(path));
        File[] files = dir.listFiles();
        
        if (files != null) {
            for (File f : files) {
                if (f.isFile()) {
                    PImage img = loadImage(f.getAbsolutePath());
                    images.put(f.getName(), img);
                }
            }
        }
    }
    
    PImage getImage(String filename) {
        PImage img = images.get(filename);
        if (img == null) {
            println("Image not found: " + filename);
        }
        return img;
    }
}
