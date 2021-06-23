
////////////////////////////////////////////////////
//
//    W_FreqSound.pde
//
//    This is a band power visualization widget!
//    (Couldn't think up more)
//    This is for visualizing the power of each brainwave band: delta, theta, alpha, beta, gamma
//    Averaged over all channels
//
//    Created by: C. Creusere, Feb. 2019
//
///////////////////////////////////////////////////,

// Minim minim;
// AudioOutput out;

//// the Oscil we use for modulating frequency.
// Oscil wave1, wave2, wave3, wave4, wave5;
// Summer audio_out;

class W_FreqSound extends Widget {

  GPlot plot3;
  String bands[] = {"DELTA", "THETA", "ALPHA", "BETA", "GAMMA"};

  
  W_FreqSound(PApplet _parent){
    super(_parent); //calls the parent CONSTRUCTOR method of Widget (DON'T REMOVE)

    //This is the protocol for setting up dropdowns.
    //Note that these 3 dropdowns correspond to the 3 global functions below
    //You just need to make sure the "id" (the 1st String) has the same name as the corresponding function
    addDropdown("ContrSound", "Control Sound", Arrays.asList("Start Sound","Stop Sound"), 0);
    // addDropdown("Dropdown2", "Drop 2", Arrays.asList("C", "D", "E"), 1);
    // addDropdown("Dropdown3", "Drop 3", Arrays.asList("F", "G", "H", "I"), 3);

//   Initialize oscillators

    //minim = new Minim( this );
    //out   = minim.getLineOut();
    //audio_out = new Summer();

    //wave1 = new Oscil( Frequency.ofPitch("A4"), 0.3f, Waves.SINE );
    //wave2 = new Oscil( Frequency.ofPitch("E5"), 0.3f, Waves.SINE );
    //wave3 = new Oscil( Frequency.ofPitch("C3"), 0.3f, Waves.SINE );
    //wave4 = new Oscil( Frequency.ofPitch("D2"), 0.3f, Waves.SINE );
    //wave5 = new Oscil( Frequency.ofPitch("C4"), 0.3f, Waves.SINE );
   //<>//
    
    // Setup for the third plot
    plot3 = new GPlot(_parent, x, y-navHeight, w, h+navHeight);
    plot3.setPos(x, y);
    plot3.setDim(w, h);
    plot3.setLogScale("y");
    plot3.setYLim(0.1, 100);
    plot3.setXLim(0, 5);
    plot3.getYAxis().setNTicks(9);
    plot3.getTitle().setTextAlignment(LEFT);
    plot3.getTitle().setRelativePos(0);
    plot3.getYAxis().getAxisLabel().setText("(uV)^2 / Hz per channel");
    plot3.getYAxis().getAxisLabel().setTextAlignment(RIGHT);
    plot3.getYAxis().getAxisLabel().setRelativePos(1);
    // plot3.setPoints(points3);
    plot3.startHistograms(GPlot.VERTICAL);
    plot3.getHistogram().setDrawLabels(true);
    //plot3.getHistogram().setRotateLabels(true);
    plot3.getHistogram().setBgColors(new color[] {
      color(0, 0, 255, 50), color(0, 0, 255, 100),
      color(0, 0, 255, 150), color(0, 0, 255, 200)
    }
    );

  }

  void update(){
    super.update(); //calls the parent update() method of Widget (DON'T REMOVE)
    float mval,t_power;
    int k,m;
 

    GPointsArray points3 = new GPointsArray(dataProcessing.headWidePower.length);
    points3.add(DELTA + 0.5, dataProcessing.avgPowerInBins[1][ALPHA], "ALPHA Ch 1");
    points3.add(THETA + 0.5, dataProcessing.avgPowerInBins[2][ALPHA], "ALPHA Ch 2");
    points3.add(ALPHA + 0.5, dataProcessing.avgPowerInBins[3][ALPHA], "ALPHA Ch3");
    points3.add(BETA + 0.5, dataProcessing.avgPowerInBins[4][ALPHA], "ALPHA Ch 4");
    points3.add(GAMMA + 0.5, dataProcessing.avgPowerInBins[5][ALPHA], "ALPHA Ch 5");

    plot3.setPoints(points3);
    plot3.getTitle().setText("Band Power");
// System.out.println("Alpha: " + dataProcessing.headWidePower[ALPHA]);

// Select relative note amplitudes based on relative band power
   t_power = 0.0;
   for(k=0;k<5;k++) {
     t_power += dataProcessing.headWidePower[k];
   }
   
   wave1.setAmplitude(dataProcessing.headWidePower[ALPHA]/t_power);
   wave2.setAmplitude(dataProcessing.headWidePower[DELTA]/t_power); 
   wave3.setAmplitude(dataProcessing.headWidePower[THETA]/t_power);
   wave4.setAmplitude(dataProcessing.headWidePower[BETA]/t_power);   
   wave5.setAmplitude(dataProcessing.headWidePower[GAMMA]/t_power);
   
// Select note based on electrode with most alpha power
 
   m = 0;
   mval = dataProcessing.avgPowerInBins[1][ALPHA];
   for(k=1;k<nchan;k++) {
     if (dataProcessing.avgPowerInBins[k][ALPHA] > mval) {
       mval = dataProcessing.avgPowerInBins[k][ALPHA];
       m = k;
     }
   }
   
   switch (m) {
     case 1: wave1.setFrequency(Frequency.ofPitch("F3"));
             break;
     case 2: wave1.setFrequency(Frequency.ofPitch("G3"));
             break;
     case 3: wave1.setFrequency(Frequency.ofPitch("A3"));
             break;  
     case 4: wave1.setFrequency(Frequency.ofPitch("B3"));
             break;              
     case 5: wave1.setFrequency(Frequency.ofPitch("C4"));
             break;
     case 6: wave1.setFrequency(Frequency.ofPitch("D4"));
             break;
     case 7: wave1.setFrequency(Frequency.ofPitch("E4"));
             break;  
     case 8: wave1.setFrequency(Frequency.ofPitch("F4"));
             break;     
     case 9: wave1.setFrequency(Frequency.ofPitch("G4"));
             break;
     case 10: wave1.setFrequency(Frequency.ofPitch("A4"));
             break;
     case 11: wave1.setFrequency(Frequency.ofPitch("B4"));
             break;  
     case 12: wave1.setFrequency(Frequency.ofPitch("C5"));
             break;
     case 13: wave1.setFrequency(Frequency.ofPitch("D5"));
             break;
     case 14: wave1.setFrequency(Frequency.ofPitch("E5"));
             break;
     case 15: wave1.setFrequency(Frequency.ofPitch("F5"));
             break;  
     case 16: wave1.setFrequency(Frequency.ofPitch("G5"));
             break;              
     }
     
// Select note based on electrode with most delta power
 
   m = 0;
   mval = dataProcessing.avgPowerInBins[1][DELTA];
   for(k=1;k<nchan;k++) {
     if (dataProcessing.avgPowerInBins[k][DELTA] > mval) {
       mval = dataProcessing.avgPowerInBins[k][DELTA];
       m = k;
     }
   }
   
   switch (m) {
 
     case 1: wave2.setFrequency(Frequency.ofPitch("G4"));
             break;
     case 2: wave2.setFrequency(Frequency.ofPitch("A4"));
             break;
     case 3: wave2.setFrequency(Frequency.ofPitch("B4"));
             break;  
     case 4: wave2.setFrequency(Frequency.ofPitch("C5"));
             break;
     case 5: wave2.setFrequency(Frequency.ofPitch("D5"));
             break;
     case 6: wave2.setFrequency(Frequency.ofPitch("E5"));
             break;
     case 7: wave2.setFrequency(Frequency.ofPitch("F5"));
             break;  
     case 8: wave2.setFrequency(Frequency.ofPitch("G5"));
             break;
     case 9: wave2.setFrequency(Frequency.ofPitch("A5"));
             break;
     case 10: wave2.setFrequency(Frequency.ofPitch("B5"));
             break;
     case 11: wave2.setFrequency(Frequency.ofPitch("C6"));
             break;  
     case 12: wave2.setFrequency(Frequency.ofPitch("D6"));
             break;              
     case 13: wave2.setFrequency(Frequency.ofPitch("E6"));
             break;
     case 14: wave2.setFrequency(Frequency.ofPitch("F6"));
             break;
     case 15: wave2.setFrequency(Frequency.ofPitch("G6"));
             break;  
     case 16: wave2.setFrequency(Frequency.ofPitch("A6"));
             break;                  
     }
      
// Select note based on electrode with most theta power
 
   m = 0;
   mval = dataProcessing.avgPowerInBins[1][THETA];
   for(k=1;k<nchan;k++) {
     if (dataProcessing.avgPowerInBins[k][THETA] > mval) {
       mval = dataProcessing.avgPowerInBins[k][THETA];
       m = k;
     }
   }
   
   switch (m) {
     case 1: wave3.setFrequency(Frequency.ofPitch("A5"));
             break;
     case 2: wave3.setFrequency(Frequency.ofPitch("B5"));
             break;
     case 3: wave3.setFrequency(Frequency.ofPitch("C6"));
             break;  
     case 4: wave3.setFrequency(Frequency.ofPitch("D6"));
             break;              
     case 5: wave3.setFrequency(Frequency.ofPitch("E6"));
             break;
     case 6: wave3.setFrequency(Frequency.ofPitch("F6"));
             break;
     case 7: wave3.setFrequency(Frequency.ofPitch("G6"));
             break;  
     case 8: wave3.setFrequency(Frequency.ofPitch("A6"));
             break;                  
     case 9: wave3.setFrequency(Frequency.ofPitch("B6"));
             break;
     case 10: wave3.setFrequency(Frequency.ofPitch("C7"));
             break;
     case 11: wave3.setFrequency(Frequency.ofPitch("D7"));
             break;  
     case 12: wave3.setFrequency(Frequency.ofPitch("E7"));
             break;
     case 13: wave3.setFrequency(Frequency.ofPitch("F7"));
             break;
     case 14: wave3.setFrequency(Frequency.ofPitch("G7"));
             break;
     case 15: wave3.setFrequency(Frequency.ofPitch("A7"));
             break;  
     case 16: wave3.setFrequency(Frequency.ofPitch("B7"));
             break;              
     }
 
      // Select note based on electrode with most beta power
 
   m = 0;
   mval = dataProcessing.avgPowerInBins[1][BETA];
   for(k=1;k<nchan;k++) {
     if (dataProcessing.avgPowerInBins[k][BETA] > mval) {
       mval = dataProcessing.avgPowerInBins[k][BETA];
       m = k;
     }
   }
   
   switch (m) {
     case 1: wave4.setFrequency(Frequency.ofPitch("B6"));
             break;
     case 2: wave4.setFrequency(Frequency.ofPitch("C7"));
             break;
     case 3: wave4.setFrequency(Frequency.ofPitch("D7"));
             break;  
     case 4: wave4.setFrequency(Frequency.ofPitch("E7"));
             break;
     case 5: wave4.setFrequency(Frequency.ofPitch("F7"));
             break;
     case 6: wave4.setFrequency(Frequency.ofPitch("G7"));
             break;
     case 7: wave4.setFrequency(Frequency.ofPitch("A7"));
             break;  
     case 8: wave4.setFrequency(Frequency.ofPitch("B7"));
             break; 
     case 9: wave4.setFrequency(Frequency.ofPitch("C8"));
             break;
     case 10: wave4.setFrequency(Frequency.ofPitch("D8"));
             break;
     case 11: wave4.setFrequency(Frequency.ofPitch("E8"));
             break;  
     case 12: wave4.setFrequency(Frequency.ofPitch("F8"));
             break;
     case 13: wave4.setFrequency(Frequency.ofPitch("G8"));
             break;
     case 14: wave4.setFrequency(Frequency.ofPitch("A8"));
             break;
     case 15: wave4.setFrequency(Frequency.ofPitch("B8"));
             break;  
     case 16: wave4.setFrequency(Frequency.ofPitch("C9"));
             break;              
     }
  
 // Select note based on electrode with most gamma power
 
   m = 0;
   mval = dataProcessing.avgPowerInBins[1][GAMMA];
   for(k=1;k<nchan;k++) {
     if (dataProcessing.avgPowerInBins[k][GAMMA] > mval) {
       mval = dataProcessing.avgPowerInBins[k][GAMMA];
       m = k;
     }
   }
   
   switch (m) {
     case 1: wave5.setFrequency(Frequency.ofPitch("F2"));
             break;
     case 2: wave5.setFrequency(Frequency.ofPitch("G2"));
             break;
     case 3: wave5.setFrequency(Frequency.ofPitch("A2"));
             break;  
     case 4: wave5.setFrequency(Frequency.ofPitch("B2"));
             break;              
     case 5: wave5.setFrequency(Frequency.ofPitch("C3"));
             break;
     case 6: wave5.setFrequency(Frequency.ofPitch("D3"));
             break;
     case 7: wave5.setFrequency(Frequency.ofPitch("E3"));
             break;  
     case 8: wave5.setFrequency(Frequency.ofPitch("F3"));
             break;     
     case 9: wave5.setFrequency(Frequency.ofPitch("G3"));
             break;
     case 10: wave5.setFrequency(Frequency.ofPitch("A3"));
             break;
     case 11: wave5.setFrequency(Frequency.ofPitch("B3"));
             break;  
     case 12: wave5.setFrequency(Frequency.ofPitch("C4"));
             break;
     case 13: wave5.setFrequency(Frequency.ofPitch("D4"));
             break;
     case 14: wave5.setFrequency(Frequency.ofPitch("E4"));
             break;
     case 15: wave5.setFrequency(Frequency.ofPitch("F4"));
             break;  
     case 16: wave5.setFrequency(Frequency.ofPitch("G4"));
             break;              
     }
     
 //  f1 = 40*dataProcessing.headWidePower[DELTA] + 200;
   //f1 = 40*dataProcessing.avgPowerInBins[1][DELTA] + 200;
   //f2 = 50*dataProcessing.headWidePower[THETA] + 1000;
   //f3 = 50*dataProcessing.headWidePower[ALPHA] + 2000;
   //f4 = 50*dataProcessing.headWidePower[BETA] + 3000;
   //f5 = 50*dataProcessing.headWidePower[GAMMA] + 4000;
   
   
     
 // System.out.println("Number of Channels: " + nchan);
//  System.out.println("f2: " + f2);

 // wave3 = new Oscil( Frequency.ofPitch("C3"), 0.3f, Waves.SINE );
   //wave1.setFrequency(round(f1));
   //wave2.setFrequency(round(f2));
   //wave3.setFrequency(round(f3));
   //wave4.setFrequency(round(f4));
   //wave5.setFrequency(round(f5));

  }

  void draw(){
    super.draw(); //calls the parent draw() method of Widget (DON'T REMOVE)

    //put your code here... //remember to refer to x,y,w,h which are the positioning variables of the Widget class
    // Draw the third plot
    plot3.beginDraw();
    plot3.drawBackground();
    plot3.drawBox();
    plot3.drawYAxis();
    plot3.drawTitle();
    plot3.drawHistograms();
    plot3.endDraw();
   
  
  }

  void screenResized(){
    super.screenResized(); //calls the parent screenResized() method of Widget (DON'T REMOVE)

    //put your code here...
    plot3.setPos(x, y-navHeight);//update position
    plot3.setOuterDim(w, h+navHeight);//update dimensions


  }

  void mousePressed(){
    super.mousePressed(); //calls the parent mousePressed() method of Widget (DON'T REMOVE)


  }

  void mouseReleased(){
    super.mouseReleased(); //calls the parent mouseReleased() method of Widget (DON'T REMOVE)

    //put your code here...

  }

  //add custom functions here
  void customFunction(){
    //this is a fake function... replace it with something relevant to this widget

  }

};

//// //These functions need to be global! These functions are activated when an item from the corresponding dropdown is selected
// void ContrSound(int n){
//   println("Item " + (n+1) + " selected from Dropdown 1");
//   if(n==0){
//     wave1.patch( audio_out );
//     wave2.patch( audio_out );
//     wave3.patch( audio_out );
//     wave4.patch( audio_out );    
//     wave5.patch( audio_out );        
//     audio_out.patch( out );
//    }
//   else if(n==1){
//     audio_out.unpatch ( out );
//     wave1.unpatch( audio_out );
//     wave2.unpatch( audio_out );
//     wave3.unpatch( audio_out );
//     wave4.unpatch( audio_out ); 
//     wave5.unpatch( audio_out );      
//   }
////   else if (n==2){
////   }
   
////
//   closeAllDropdowns(); // do this at the end of all widget-activated functions to ensure proper widget interactivity ... we want to make sure a click makes the menu close
// }
//
// void Dropdown2(int n){
//   println("Item " + (n+1) + " selected from Dropdown 2");
//   closeAllDropdowns();
// }
//
// void Dropdown3(int n){
//   println("Item " + (n+1) + " selected from Dropdown 3");
//   closeAllDropdowns();
// }
