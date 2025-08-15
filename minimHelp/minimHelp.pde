import ddf.minim.*;
import ddf.minim.spi.*; 
import ddf.minim.ugens.*;
import java.util.HashMap;
import themidibus.*; // Import the MidiBus library

BitCrush bitCrush;

Minim minim;
static final int QTY = 53;
final Sampler[] samples = new Sampler[QTY];
final TickRate[] rateControl = new TickRate[QTY];
AudioOutput out;
HashMap<Character, Integer> keyToSampleMap;

// MIDI variables
MidiBus myBus;

// Volume control variable
float volume = 0.0f; // in decibels, default to 0 dB (no change)

void setup() {
  //fullScreen();
  size(1200,800);
  noCursor();
  
  // Create our Minim object
  minim = new Minim(this);
  out = minim.getLineOut();
  
  // Create a BitCrush UGen with an 8-bit resolution
  bitCrush = new BitCrush(8, out.sampleRate());
  
  // Set initial gain
  out.setGain(volume);

  // Load samples
  String[] sampleFiles = {
    "drum-loop.wav"
  };
  
  for (int i = 0; i < sampleFiles.length; i++) {
    println("Loading sample: " + sampleFiles[i]);
    try {
      samples[i] = new Sampler(sampleFiles[i], 1, minim);
      rateControl[i] = new TickRate(1.f);
      samples[i].patch(rateControl[i]).patch(bitCrush).patch(out);
      rateControl[i].setInterpolation(true);
      rateControl[i].value.setLastValue(1.f);
    } catch (Exception e) {
      println("Error loading sample: " + sampleFiles[i]);
      e.printStackTrace();
    }
  }
  
  // Map keys to samples
  keyToSampleMap = new HashMap<Character, Integer>();
  char[] keys = {'q', 'a', 'z', 'w', 's', 'x', 'e', 'd', 'c', 'r', 'f', 'v', 't', 'g', 'b', 
                 'y', 'h', 'n', 'u', 'j', 'i', 'k', 'm', 'o', 'l', 'p', '1', '2', '3', '4', 
                 '5', '6', '7', '8', '9', '0', ' ', ',', '.', '/', ';', '[', ']', '-', '=', '+'};
  
  for (int i = 0; i < keys.length; i++) {
    keyToSampleMap.put(keys[i], i);
  }
  
  // Initialize MIDI
  MidiBus.list(); // List available MIDI devices
  myBus = new MidiBus(this, "Bluetooth", "Bluetooth"); // Create a new MidiBus with the first input device
}

void draw() {
  // No rate control based on mouse position anymore
  
  // Draw waveforms
  background(0);
  stroke(255);
  strokeWeight(2);
  
  for (int i = 0; i < out.bufferSize() - 1; i++) {
    float x1 = map(i, 0, out.bufferSize(), 0, width);
    float x2 = map(i + 1, 0, out.bufferSize(), 0, width);
    line(x1, height / 2 - out.left.get(i) * 150, x2, height / 2 - out.left.get(i + 1) * 150);
  }
}

void keyPressed() {
  Integer sampleIndex = keyToSampleMap.get(key);
  if (sampleIndex != null && sampleIndex < samples.length && samples[sampleIndex] != null) {
    samples[sampleIndex].trigger();
  }
}

// MIDI control functions
void controllerChange(int channel, int number, int value) {
  println("Controller Change:");
  println("--------");
  println("Channel:" + channel);
  println("Number:" + number);
  println("Value:" + value);
  println();

  if (number == 13) { // CC 1 controls rate
    float rate = map(value, 0, 127, 0.5f, 2.0f); // Map MIDI value to rate between 0.5x and 2x
    for (TickRate rc : rateControl) {
      if (rc != null) {
        rc.value.setLastValue(rate);
      }
    }
  } else if (number == 14) { // CC 7 commonly used for volume control
    // Map value from 0 (mute) to 1 (full volume), then convert to decibels
    float gain = map(value, 0, 127, -80, 6); // from -80 dB (mute) to +6 dB
    out.setGain(gain);
  } else if (number == 81) { // CC 10 will be used as the quit button
    if (value == 127) { // Button pressed
      println("Quit button pressed. Exiting program.");
      exit();
    }
  }
}
