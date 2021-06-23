
////////////////////////////////////////////////////
//
//    W_template.pde (ie "Widget Template")
//
//    This is a Template Widget, intended to be used as a starting point for OpenBCI Community members that want to develop their own custom widgets!
//    Good luck! If you embark on this journey, please let us know. Your contributions are valuable to everyone!
//
//    Created by: Aya Elsayed, Feb 2020
//
///////////////////////////////////////////////////,
float rel_power[] = new float[5];
class W_rollover_aya extends Widget {

    //to see all core variables/methods of the Widget class, refer to Widget.pde
    //put your custom variables here...
    Button widgetTemplateButton;

   W_rollover_aya(PApplet _parent){
        super(_parent); //calls the parent CONSTRUCTOR method of Widget (DON'T REMOVE)

        //This is the protocol for setting up dropdowns.
        //Note that these 3 dropdowns correspond to the 3 global functions below
        //You just need to make sure the "id" (the 1st String) has the same name as the corresponding function
        addDropdown("Dropdown1", "Drop 1", Arrays.asList("A", "B"), 0);
        addDropdown("Dropdown2", "Drop 2", Arrays.asList("C", "D", "E"), 1);
        addDropdown("Dropdown3", "Drop 3", Arrays.asList("F", "G", "H", "I"), 3);
        
        
        
       
        widgetTemplateButton = new Button (x + w/2, y + h/2, 200, navHeight, "Learn about brain bands!", 12);
        widgetTemplateButton.setFont(p4, 14);
        widgetTemplateButton.setColorNotPressed(color(0,220,105));
        widgetTemplateButton.setURL("http://www.zensound.co.uk/understanding-brainwave-frequencies/");
    }

    void update(){
        super.update(); //calls the parent update() method of Widget (DON'T REMOVE)
 
        
        
        
        
        
        //If using a TopNav object, ignore interaction with widget object (ex. widgetTemplateButton)
        if (topNav.configSelector.isVisible || topNav.layoutSelector.isVisible) {
            widgetTemplateButton.setIsActive(false);
            widgetTemplateButton.setIgnoreHover(true);
        } else {
            widgetTemplateButton.setIgnoreHover(false);
        }

    }

    void draw(){
        super.draw(); //calls the parent draw() method of Widget (DON'T REMOVE)

        //put your code here... //remember to refer to x,y,w,h which are the positioning variables of the Widget class
        pushStyle();

        //widgetTemplateButton.draw();
       float t_power;
       int k,m;
        //put your code here...
        
        // Select relative note amplitudes based on relative band power
         t_power = 0.0;
         for(k=0;k<5;k++) {
           t_power += dataProcessing.headWidePower[k];
         }
         
         // Set relative power array for use in updating the headplot color intensity and voice loudness
         rel_power[0] = dataProcessing.headWidePower[THETA]/t_power;
         rel_power[1] = dataProcessing.headWidePower[DELTA]/t_power;
         rel_power[2] = dataProcessing.headWidePower[ALPHA]/t_power;
         rel_power[3] = dataProcessing.headWidePower[BETA]/t_power;
         rel_power[4] = dataProcessing.headWidePower[GAMMA]/t_power;
   
         
        //float temp[] = rel_power;
        float max_band = 0.0;
        max_band = max(rel_power);
        //println("max band",max_band);
        //print("watching power");
        //println(rel_power[0]*t_power);println(rel_power[1]);println(rel_power[2]);println(rel_power[3]);println(rel_power[4]);
        int i;
        int p =0;
       for (i=0;i<5;i++)
        {
          //println("i",i);
          if (rel_power[i] == max_band)
          {
            p=i;
            //println("p",p);
            break;
          }
        }
        //println("new p",recieved_Data);
        //pp = datatorecieve[1];
         switch (recieved_Data)
         {
           case 0 : //Theta
             fill(213,100,124);//2
             rect(x,y,w,h);
             //println("theta");
             break;
          case 1 : //delta
             fill(231,161,176);//1
             rect(x,y,w,h);
              println("delta");
              break;
          case  2 : //alpha
               fill(236,03,183);//3
               rect(x,y,w,h);
                println("alpha");
                break;
          case  3 : //beta
             fill(156,34,93);//4
             rect(x,y,w,h);
              println("beta");
              break;
          case 4: //gamma
             fill(0);//5
             rect(x,y,w,h);
              println("gamma");
              break;
           
           
         }
        
        
        
         /*
         if (rel_power[0]> rel_power[2] ) //if relative power of Theta in all electodes is bigger than alpha power
         {
          
          fill(0,0,255);
          rect(x,y,w,h);
             println("black");
         }
         
         else 
         {
           fill(0,255,0);
           rect(x,y,w,h);
          //background (0,255,0);
           println("whigt");
         }
             */ 
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
        //If using a TopNav object, ignore interaction with widget object (ex. widgetTemplateButton)
        if (!topNav.configSelector.isVisible && !topNav.layoutSelector.isVisible) {
            if(widgetTemplateButton.isMouseHere()){
                widgetTemplateButton.setIsActive(true);
            }
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
void Dropdown1a(int n){
    println("Item " + (n+1) + " selected from Dropdown 1");
    if(n==0){
        //do this
    } else if(n==1){
        //do this instead
    }

    closeAllDropdowns(); // do this at the end of all widget-activated functions to ensure proper widget interactivity ... we want to make sure a click makes the menu close
}

void Dropdown2a(int n){
    println("Item " + (n+1) + " selected from Dropdown 2");
    closeAllDropdowns();
}

void Dropdown3a(int n){
    println("Item " + (n+1) + " selected from Dropdown 3");
    closeAllDropdowns();
}
