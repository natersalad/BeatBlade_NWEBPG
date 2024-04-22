import javax.sound.midi.*;

class BeatMap {
    
    private long startTime;
    private long calibrationOffset;
    
    Sequence sequence;
    ArrayList<Long> beats; // The beats
    int threshold; // The threshold for being on beat
    float beatInterval; // The interval between beats
    
    
    BeatMap(String filename, int threshold, long calibrationOffset) {
        try {
            File file = new File(sketchPath(filename));
            println(file.getAbsolutePath());
            sequence = MidiSystem.getSequence(file);
        } catch(InvalidMidiDataException | IOException e) {
            e.printStackTrace();
        }
        
        beats = new ArrayList<Long>();
        this.threshold = threshold;
        this.calibrationOffset = calibrationOffset;
        
        int resolution = sequence.getResolution();
        long microsecondsPerTick = sequence.getMicrosecondLength() / sequence.getTickLength();
        
        // Initialize the max beats and best track variables
        int maxBeats = 0;
        Track bestTrack = null;
        
        // Loop through each track
        for (Track track : sequence.getTracks()) {
            // Count the number of beats in this track
            int numBeats = 0;
            for (int i = 0; i < track.size(); i++) {
                MidiEvent event = track.get(i);
                MidiMessage message = event.getMessage();
                if (message instanceof ShortMessage) {
                    ShortMessage sm = (ShortMessage) message;
                    if (sm.getCommand() == ShortMessage.NOTE_ON) {
                        numBeats++;
                    }
                }
            }
            
            // If this track has more beats than the current best track, update the best track
            if (numBeats > maxBeats) {
                maxBeats = numBeats;
                bestTrack = track;
            }
        }
        
        // Use the best track
        for (int i = 0; i < bestTrack.size(); i++) {
            MidiEvent event = bestTrack.get(i);
            MidiMessage message = event.getMessage();
            if (message instanceof ShortMessage) {
                ShortMessage sm = (ShortMessage) message;
                if (sm.getCommand() == ShortMessage.NOTE_ON) {
                    long milliseconds = (event.getTick() * microsecondsPerTick) / 1000;
                    beats.add(milliseconds + calibrationOffset); 
                }
            }
        }
        
        startTime = System.currentTimeMillis();
        printClickTimes();
        beatInterval = sequence.getMicrosecondLength() / 1000f / beats.size();
        printClickTimes();
    }
    
    long getStartTime() {
        return startTime;
    }
    
    float getCurrentBeatPosition() {
        long currentTime = System.currentTimeMillis() - startTime;
        int currentBeatIndex = (int)((currentTime - calibrationOffset) / beatInterval);
        if (currentBeatIndex < beats.size()) {
            long timeDifference = currentTime - beats.get(currentBeatIndex);
            if (timeDifference <= beatInterval) {
                return(float) timeDifference / beatInterval;
            }
        }
        return 0;
    }
    
    void printClickTimes() {
        println("You should click at the following times to be on rhythm with the beats:");
        for (long beat : beats) {
            println("Click at: " + beat + " ms");
        }
    }
    
    boolean isOnBeat() {
        // Check if the current time is within the threshold of a beat
        long currentTime = System.currentTimeMillis() - startTime;
        for (long beat : beats) {
            if (Math.abs(currentTime - beat) <= threshold) {
                println("On beat! Current time: " + currentTime + ", Beat time: " + beat);
                return true;
            }
        }
        return false;
    }
}