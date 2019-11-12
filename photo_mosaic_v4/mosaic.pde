class Mosaic {
  PImage myImage;
  PImage[] builderImages;
  color[][] colourArray;
  int builderImageNum;
  int resizeNum;
  int mainImageWidth;
  int mainImageHeight;
  String[] builderNames;
  String imageName;
  float transparencyNum;
  int i = 0;
  int j = 0;

  Mosaic(PImage img, String in, PImage[] bi, int bin, int rn, String[] bn, float tn, int mid, int mih){
    this.myImage = img;
    this.imageName = in;
    this.builderImages = bi;
    this.builderImageNum = bin;
    this.resizeNum = rn;
    this.mainImageWidth = mid;
    this.mainImageHeight = mih;
    this.builderNames = bn;
    this.transparencyNum = tn;    
  }

  void createBuilderImages() {
    this.builderImages = new PImage[this.builderImageNum];
  
    for(int i = 0; i < this.builderImages.length; i ++) {
      this.builderImages[i] = loadImage(this.builderNames[i]);         //createBuilderImages creates an array of images by using the filepaths that were
      this.builderImages[i].resize(this.resizeNum, this.resizeNum);    //imported by the user, they are also resized to the resolution the user set
    }
  }
  
  void getColours(){
    noTint();
    this.myImage = loadImage(this.imageName);
    image(this.myImage, 0, 0);          //getColours sets the base image on screen
    this.myImage.loadPixels();          // It also collects the average colour of each pixel on the base image of the mosaic
                                        //it then adds these colours to an array which the builder images will use to set their tint                                     
    colourArray = new color[this.mainImageWidth + this.resizeNum][this.mainImageHeight + this.resizeNum];
    for(int i = 0; i < this.mainImageWidth; i++) {
      for(int j = 0; j < this.mainImageHeight; j++) { 
       colourArray[i][j] = this.myImage.get(i, j);
      }    
    } 
  }

  void drawMosaic() {
    noTint();
    tint(colourArray[this.i][this.j], this.transparencyNum);
    image(this.builderImages[x], this.i, this.j);
    x = int(random(0, this.builderImages.length));          //drawMosaic generates the mosaic by randomly placing the builder images all over the screen
                                                                //it sets the tint of these images to the corresponding pixel of the base image underneath it
    if(this.i <= this.mainImageWidth - 1 && this.j <= this.mainImageHeight - 1) {
       this.i = this.i + resizeNum;
       if(this.i >= this.mainImageWidth - 1) {
          this.i = 0;
          this.j = this.j + this.resizeNum;
     }
   }
  }
}