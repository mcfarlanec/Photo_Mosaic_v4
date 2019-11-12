// Photo Mosaic Generator
// Programmed by Colin McFarlane
// Final Project ICS4UI
// January 26, 2018
import g4p_controls.*;
PImage myImage;
PImage[] builderImages;
color[][] colourArray;
int builderImageNum;
int resizeNum = 12;
int mainImageWidth;              // Setting inital global values
int mainImageHeight; 
String[] builderNames = new String[100];
String imageName;
float transparencyNum = 127.0 ;
int t = 0;
int x = 0;
int z = 0;
boolean pause = true;
Mosaic user;                        

void setup() {
  createGUI();
  frameRate(30);                //Creating the GUI and allowing the sketch window's resolution to be changed
  surface.setResizable(true);
}

void uploadImage(File selection) {
  if (selection == null) {
    pause = true;
  } 
  else {  
    String filePath  = ((selection.getAbsolutePath()));    //uploadImage gets the exact path of the file being uploaded
    imageName = filePath;                                  //and sets the base of the mosaic to that image 
 }
}

void uploadBuilderImage(File selection) {
 if (selection == null) {
    pause = true;
  } 
  else {
    String filePath  = ((selection.getAbsolutePath()));    //does the same as uploadImage, only it adds the file being uploaded
    builderNames[z] = filePath;                            //to an array of builderimages to be used as the tiles for the mosaic
    builderImageNum = builderImageNum + 1;
    z = z + 1;
 }
}

void inputMainButton() {
  selectInput("", "uploadImage");      //when the input base button is pressed, calls to uploadImage
}

void inputBuilderButton() {
  selectInput("", "uploadBuilderImage"); //when the input builder button is pressed, calls to uploadBuilderImage
}

void startButton() {
  clear();
  user = new Mosaic(myImage, imageName, builderImages, builderImageNum, resizeNum, builderNames, transparencyNum, mainImageWidth, mainImageHeight); 
  //the start button that creates the new array object with all the users varaible and sets pause to false in order to generate the mosaic
  pause = false;
}

void resetButton() {
  builderNames = new String[100];
  builderImageNum = 0;
  z = 0;
  imageName = "";
  clear();                      //reset button, clears the screen and resets all the values the user can change
  surface.setSize(100, 100);  // also resets all the images that have been uploaded
}

void saveButton() { 
 save("photomosaic.png");    //saves and exports the photomosaic that was generated as a png
}

void changeDimensions() {
 surface.setSize(mainImageWidth, mainImageHeight);     //changes the dimensions of the mosaic to whatever the user sets
}

void createMosaic() {
  user.createBuilderImages();      //using the users inputed variables calls to the mosaic class
  user.getColours();               //in order to generate the new mosaic
  if(pause == false) {                    
    for(int i = 0; i < mainImageWidth * mainImageWidth; i++) {
      user.drawMosaic();    
    }
  }
  pause = true;
}

void draw() {
  if (pause == false) {     //the mosaic doesnt need to be recreated constantly
  createMosaic();           //so the pause causes the mosaic image to only be generated once
  }
}