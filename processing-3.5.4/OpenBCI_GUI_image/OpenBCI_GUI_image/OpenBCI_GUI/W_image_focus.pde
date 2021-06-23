
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



PImage img0, img1, img2, img3, img4, img5, img6, img7;
int Current_Img = 4, DelayCnt = 0, DELAY = 5;
double LastOutput = 0.0;
boolean ImgSeqUp = false;

class W_image_focus extends Widget {

  //to see all core variables/methods of the Widget class, refer to Widget.pde
  //put your custom variables here...
  Button widgetTemplateButton;

  W_image_focus(PApplet _parent){
    super(_parent); //calls the parent CONSTRUCTOR method of Widget (DON'T REMOVE)

    //This is the protocol for setting up dropdowns.
    //Note that these 3 dropdowns correspond to the 3 global functions below
    //You just need to make sure the "id" (the 1st String) has the same name as the corresponding function
    addDropdown("Playback", "Audio", Arrays.asList("Playing", "Halted"), 1);
    addDropdown("AddNoise", "Noise", Arrays.asList("On", "Off"), 1);
 //   addDropdown("DD3", "Drop 3", Arrays.asList("F", "G", "H", "I"), 3);

  //  widgetTemplateButton = new Button (x + w/2, y + h/2, 200, navHeight, "Design Your Own Widget!", 12);
  //  widgetTemplateButton.setFont(p4, 14);
    
    img0 = loadImage("/Users/charlescreusere/Documents/processing/OpenBCI_GUI_image/Beers/Frame_0.jpg");
    img1 = loadImage("/Users/charlescreusere/Documents/processing/OpenBCI_GUI_image/Beers/Frame_1.jpg");
    img2 = loadImage("/Users/charlescreusere/Documents/processing/OpenBCI_GUI_image/Beers/Frame_2.jpg");
    img3 = loadImage("/Users/charlescreusere/Documents/processing/OpenBCI_GUI_image/Beers/Frame_3.jpg");
    img4 = loadImage("/Users/charlescreusere/Documents/processing/OpenBCI_GUI_image/Beers/Frame_4.jpg");
    img5 = loadImage("/Users/charlescreusere/Documents/processing/OpenBCI_GUI_image/Beers/Frame_5.jpg");
    img6 = loadImage("/Users/charlescreusere/Documents/processing/OpenBCI_GUI_image/Beers/Frame_6.jpg");
    img7 = loadImage("/Users/charlescreusere/Documents/processing/OpenBCI_GUI_image/Beers/Frame_7.jpg");

  }

  void update(){
    super.update(); //calls the parent update() method of Widget (DON'T REMOVE)
    double alpha_filt;
    alpha_filt = 0.97*LastOutput + 0.03*dataProcessing.headWidePower[ALPHA];
    LastOutput = alpha_filt;
    if ((dataProcessing.headWidePower[ALPHA] > alpha_filt)&&(ImgSeqUp == true))  {
       if (++DelayCnt > DELAY) {
         if (Current_Img < 7) {
           Current_Img++;
         }
         DelayCnt = 0;
       }
    } else if ((dataProcessing.headWidePower[ALPHA] < alpha_filt)&&(ImgSeqUp == false)) {
       if (++DelayCnt > DELAY) {
        if (Current_Img > 0) {
          Current_Img--;
        }
        DelayCnt = 0;
       }    
    } else if (ImgSeqUp == true) {
      DelayCnt = 0;
      ImgSeqUp = false;
    } else {
      DelayCnt = 0;
      ImgSeqUp = true;
    }
  
 //   float gain;
 //   gain = 3.0*dataProcessing.headWidePower[ALPHA];
 //   NoiseGain.setValue(gain);
    System.out.println("Current Image Displayed: " + Current_Img);
  }

  void draw(){
    super.draw(); //calls the parent draw() method of Widget (DON'T REMOVE)

    switch (Current_Img) {
      case 0:
        image(img0,x,y,w,h);
        break;
      case 1:
        image(img1,x,y,w,h);
        break; 
      case 2:
        image(img2,x,y,w,h);
        break;      
      case 3:
        image(img3,x,y,w,h);
        break;        
      case 4:
        image(img4,x,y,w,h);
        break; 
      case 5:
        image(img5,x,y,w,h);
        break;         
      case 6:
        image(img6,x,y,w,h);
        break;         
       case 7:
        image(img7,x,y,w,h);
        break;   
    }
    
    //put your code here... //remember to refer to x,y,w,h which are the positioning variables of the Widget class
 //   pushStyle();

  //  widgetTemplateButton.draw();

  //  popStyle();

  }

  void screenResized(){
    super.screenResized(); //calls the parent screenResized() method of Widget (DON'T REMOVE)

    //put your code here...
//    widgetTemplateButton.setPos(x + w/2 - widgetTemplateButton.but_dx/2, y + h/2 - widgetTemplateButton.but_dy/2);


  }

  void mousePressed(){
    super.mousePressed(); //calls the parent mousePressed() method of Widget (DON'T REMOVE)

    //put your code here...
  //  if(widgetTemplateButton.isMouseHere()){
  //    widgetTemplateButton.setIsActive(true);
 //   }

  }

  void mouseReleased(){
    super.mouseReleased(); //calls the parent mouseReleased() method of Widget (DON'T REMOVE)

    //put your code here...
 //   if(widgetTemplateButton.isActive && widgetTemplateButton.isMouseHere()){
 //     widgetTemplateButton.goToURL();
  //  }
 //   widgetTemplateButton.setIsActive(false);

  }

  //add custom functions here
  void customFunction(){
    //this is a fake function... replace it with something relevant to this widget

  }

};

//These functions need to be global! These functions are activated when an item from the corresponding dropdown is selected
void Playback(int n){
  if(n==0) {
       //println("WE ARE HERE!!!!!!"); //<>//
       //minim = new Minim(this);
       //sampleBuffer = new MultiChannelBuffer( 1, 1024 );
       //float sampleRate = minim.loadFileIntoBuffer( "/Users/charlescreusere/Documents/processing/OpenBCI_GUI_Audio/Odeoriginal.wav", sampleBuffer ); //<>//
       //System.out.println("Sample Rate: " + sampleRate); 
       //if ( sampleRate > 0 ) {
       //  OdeJoy = new Sampler( sampleBuffer, sampleRate, 1 );
       //  OdeJoy.looping = true;
       //  OdeJoy.patch ( combined_audio );
       //  combined_audio.patch(out_playback);
       //  OdeJoy.trigger();
       //  println("First Time here "+ out_playback.sampleRate());
       //  OdeJoy.printInputs();
       //}
  } else {
//      OdeJoy.stop();
//      OdeJoy.unpatch ( combined_audio );
//      combined_audio.unpatch ( out_playback );
//println("Stopped playback");
  }

  closeAllDropdowns(); // do this at the end of all widget-activated functions to ensure proper widget interactivity ... we want to make sure a click makes the menu close
}

void AddNoise(int n){
  if (n==0) {
    //NoiseGain.setValue(0.f);
    //bckgnd.patch(NoiseGain).patch(combined_audio);
//   bckgnd.patch(combined_audio);
  } else {
    //bckgnd.unpatch(NoiseGain);
    //bckgnd.unpatch(combined_audio);
 //   combined_audio.unpatch ( out_playback );
  }

  closeAllDropdowns();
}

//void DD3(int n){
//  println("Item " + (n+1) + " selected from Dropdown 3");
//  closeAllDropdowns();
//}
