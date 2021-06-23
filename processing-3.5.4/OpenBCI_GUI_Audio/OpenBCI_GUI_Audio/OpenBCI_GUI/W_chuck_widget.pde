
////////////////////////////////////////////////////
//
//    W_template.pde (ie "Widget Template")
//
//    This is a Template Widget, intended to be used as a starting point for OpenBCI Community members that want to develop their own custom widgets!
//    Good luck! If you embark on this journey, please let us know. Your contributions are valuable to everyone!
//
//    Created by: Conor Russomanno, November 2016
//
///////////////////////////////////////////////////,


MultiChannelBuffer sampleBuffer;
AudioOutput out_playback;
Sampler OdeJoy;
Summer combined_audio;
Noise bckgnd;
Gain NoiseGain;

class W_chuck_widget extends Widget {

  //to see all core variables/methods of the Widget class, refer to Widget.pde
  //put your custom variables here...
  Button widgetTemplateButton;

  W_chuck_widget(PApplet _parent){
    super(_parent); //calls the parent CONSTRUCTOR method of Widget (DON'T REMOVE)

    //This is the protocol for setting up dropdowns.
    //Note that these 3 dropdowns correspond to the 3 global functions below
    //You just need to make sure the "id" (the 1st String) has the same name as the corresponding function
    addDropdown("Playback", "Audio", Arrays.asList("Playing", "Halted"), 1);
    addDropdown("AddNoise", "Noise", Arrays.asList("On", "Off"), 1);
 //   addDropdown("DD3", "Drop 3", Arrays.asList("F", "G", "H", "I"), 3);

    widgetTemplateButton = new Button (x + w/2, y + h/2, 200, navHeight, "Design Your Own Widget!", 12);
    widgetTemplateButton.setFont(p4, 14);
    
    minim = new Minim(this);
    out_playback = minim.getLineOut();
    bckgnd = new Noise(0.125, Noise.Tint.PINK);  // Start Background noise
    NoiseGain = new Gain(0.f);  // Set starting gain to 0dB
    
    combined_audio = new Summer();
  //  combined_audio.patch(out_playback);
 //   sampleBuffer = new MultiChannelBuffer( 1, 1024 );
  //  float sampleRate = minim.loadFileIntoBuffer( "/Users/charlescreusere/Documents/processing/OpenBCI_GUI_Audio/Odeoriginal.wav", sampleBuffer );
  //  if ( sampleRate > 0 ) {
  //    OdeJoy = new Sampler( sampleBuffer, sampleRate, 1 );
  //    OdeJoy.looping = true;
  //    OdeJoy.patch ( combined_audio );
  ////    OdeJoy.trigger();
  //  }
      //OdeJoy.patch ( combined_audio );
      //combined_audio.patch(out_playback);
      //OdeJoy.trigger();
    
//    widgetTemplateButton.setURL("http://docs.openbci.com/Tutorials/15-Custom_Widgets");
    //minim = new Minim(this);
    //out_playback = minim.getLineOut();
    //sampleBuffer = new MultiChannelBuffer( 1, 1024 );
    //float sampleRate = minim.loadFileIntoBuffer( "/Users/charlescreusere/Documents/processing/OpenBCI_GUI_Audio/Odeoriginal.wav", sampleBuffer );
    //if ( sampleRate > 0 ) {
    //  OdeJoy = new Sampler( sampleBuffer, sampleRate, 1 );
    //  OdeJoy.patch ( out_playback );
    //}

 //   OdeJoy.trigger();
 //  System.out.println("Sample Rate: " + sampleRate);   

 //   audio_out = new Summer();
  }

  void update(){
    super.update(); //calls the parent update() method of Widget (DON'T REMOVE)
    float gain;
    gain = 3.0*dataProcessing.headWidePower[ALPHA];
    NoiseGain.setValue(gain);
    System.out.println("Gain: " + gain);
  }

  void draw(){
    super.draw(); //calls the parent draw() method of Widget (DON'T REMOVE)

    //put your code here... //remember to refer to x,y,w,h which are the positioning variables of the Widget class
    pushStyle();

    widgetTemplateButton.draw();

    popStyle();

  }

  void screenResized(){
    super.screenResized(); //calls the parent screenResized() method of Widget (DON'T REMOVE)

    //put your code here...
    widgetTemplateButton.setPos(x + w/2 - widgetTemplateButton.but_dx/2, y + h/2 - widgetTemplateButton.but_dy/2);


  }

  void mousePressed(){
    super.mousePressed(); //calls the parent mousePressed() method of Widget (DON'T REMOVE)

    //put your code here...
    if(widgetTemplateButton.isMouseHere()){
      widgetTemplateButton.setIsActive(true);
    }

  }

  void mouseReleased(){
    super.mouseReleased(); //calls the parent mouseReleased() method of Widget (DON'T REMOVE)

    //put your code here...
    if(widgetTemplateButton.isActive && widgetTemplateButton.isMouseHere()){
      widgetTemplateButton.goToURL();
    }
    widgetTemplateButton.setIsActive(false);

  }

  //add custom functions here
  void customFunction(){
    //this is a fake function... replace it with something relevant to this widget

  }

};

//These functions need to be global! These functions are activated when an item from the corresponding dropdown is selected
void Playback(int n){
  if(n==0) {
       println("WE ARE HERE!!!!!!"); //<>//
       minim = new Minim(this);
       sampleBuffer = new MultiChannelBuffer( 1, 1024 );
       float sampleRate = minim.loadFileIntoBuffer( "/Users/charlescreusere/Documents/processing/OpenBCI_GUI_Audio/Odeoriginal.wav", sampleBuffer ); //<>//
       System.out.println("Sample Rate: " + sampleRate); 
       if ( sampleRate > 0 ) {
         OdeJoy = new Sampler( sampleBuffer, sampleRate, 1 );
         OdeJoy.looping = true;
         OdeJoy.patch ( combined_audio );
         combined_audio.patch(out_playback);
         OdeJoy.trigger();
         println("First Time here "+ out_playback.sampleRate());
         OdeJoy.printInputs();
       }
  } else {
      OdeJoy.stop();
      OdeJoy.unpatch ( combined_audio );
      combined_audio.unpatch ( out_playback );
println("Stopped playback");
  }

  closeAllDropdowns(); // do this at the end of all widget-activated functions to ensure proper widget interactivity ... we want to make sure a click makes the menu close
}

void AddNoise(int n){
  if (n==0) {
    NoiseGain.setValue(0.f);
    bckgnd.patch(NoiseGain).patch(combined_audio);
//   bckgnd.patch(combined_audio);
  } else {
    bckgnd.unpatch(NoiseGain);
    bckgnd.unpatch(combined_audio);
 //   combined_audio.unpatch ( out_playback );
  }

  closeAllDropdowns();
}

//void DD3(int n){
//  println("Item " + (n+1) + " selected from Dropdown 3");
//  closeAllDropdowns();
//}
