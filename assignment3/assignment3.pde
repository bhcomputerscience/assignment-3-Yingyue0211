/**
 *Assignment 3
 * This is a cake-making game.
 * 
 * There are three optional decorations: jam, cream, and fruit.
 * The gameplay is  following:
 * 
 * 1. Drag the cake to the middle plate.
 *    (If the cake is dragged to any other place, it will return to its original place.)
 * 
 * 2. Choose a jam flavor pressing number keys:
 *    1 = strawberry jam
 *    2 = blueberry jam
 *    3 = mango jam
 * 
 * 3. Drag the piping bag onto the cake to add cream.
 * 
 * 4. Click on a fruit to place it on the cake.
 * 
 * You can decorate the cake in any order to combine fruits, jams, and cream.
 * 
 * Press the Delete key to clear all and reset the game.
 *
 * @author Yingyue Zhang
 * @date Jan 12, 2026
 */

PImage tableIM, cakeIM, pipingbagIM;
PImage strawjamIM, bluejamIM, mangojamIM;//jam cans
PImage strawjamckIM, bluejamckIM, mangojamckIM;// jams on cake
PImage mangockIM, blueckIM, strawckIM;//fruit on cake
PImage strawIM, blueIM, mangoIM;// real fruit( fruit bag)
PImage creamIM;// cream on cake

// Table
final int TABLE_X = 60, TABLE_Y = 75;

//cake
final int CAKE_WIDTH = 250;
final int CAKE_HEIGHT = 200;

// pink small plate (mango)
final float PINK_SM_PLATE_STARTX = 750/4-70, PINK_SM_PLATE_ENDX = 750/4+30;
final float PINK_SM_PLATE_STARTY = 500/2+10, PINK_SM_PLATE_ENDY = 500/2+55;

// pink big plate: strawberry
final float PINK_BIG_PLATE_STARTX = 750/5.2, PINK_BIG_PLATE_ENDX = 750/5.2+100;
final float PINK_BIG_PLATE_STARTY = 500/2-10, PINK_BIG_PLATE_ENDY = 500/2-60;  

// pipingbag
int pipingbag_x = 500, pipingbag_y = 250;
final float PIPINGBAG_WIDTH_STRETCH = 4.0, PIPINGBAG_HEIGHT_STRETCH = 2.7;

// jam cans
final int JAMCANS_MANGO_X_SFT = 20, JAMCANS_MANGO_Y_PISI = 110;
final int JAMCANS_STRAW_X_SFT = 120, JAMCANS_STRAW_Y_PISI = 110;
final int JAMCANS_BLUE_X_SFT = 65, JAMCANS_BLUE_Y_PISI = 130;
final float JAMCANS_WIDTH_STRETCH = 7.5, JAMCANS_HEIGHT_STRETCH = 4;

// cake in plate
final float CAKE_ARVD_X = 750/2-250, CAKE_ARVD_Y = 500/2-80;

// only fruit in plate
final int FRUITS_CK_Y_SHIFT = 50;

//cake first(setting) place
float cakeX = 300;
float cakeY = 55;
float setX, setY;//pipingbag move (x,y)

//fruit and jam type
int fruit_type = 0;
final int strawberry = 1;
final int blueberry = 2;
final int mango = 3;

int jam_type = 0;


boolean cake_arrived = false;
boolean cream_applied = false;  
boolean draggingPipingBag = false;



void setup() {
  size(750, 500);
  //table
  tableIM = loadImage("table.png");
  //jam cans
  mangojamIM = loadImage("mangojam.png");
  strawjamIM = loadImage("strawjam.png");
  bluejamIM = loadImage("bluejam.png");
  //jam on cake
  strawjamckIM = loadImage("strawjamck.png");
  bluejamckIM = loadImage("bluejamck.png");
  mangojamckIM = loadImage("mangojamck.png");
  //fruits on cake
  mangockIM = loadImage("mangock.png");
  blueckIM = loadImage("blueck.png");
  strawckIM = loadImage("strawck.png");
  //fruits bags(real fruits)
  strawIM = loadImage("straw.png");
  blueIM = loadImage("blue.png");
  mangoIM = loadImage("mango.png");
  
  pipingbagIM = loadImage("pipingbag.png");
  cakeIM = loadImage("cake.png");
  creamIM = loadImage("cream.png"); 
}

void draw() 
{
  background(#f7edf1);

  // table
  image(tableIM, TABLE_X, TABLE_Y);

  // jam cans
  image(mangojamIM, width/2-JAMCANS_MANGO_X_SFT, JAMCANS_MANGO_Y_PISI, width/JAMCANS_WIDTH_STRETCH, height/JAMCANS_HEIGHT_STRETCH);
  image(strawjamIM, width/2-JAMCANS_STRAW_X_SFT, JAMCANS_STRAW_Y_PISI, width/JAMCANS_WIDTH_STRETCH, height/JAMCANS_HEIGHT_STRETCH);
  image(bluejamIM, width/2-JAMCANS_BLUE_X_SFT, JAMCANS_BLUE_Y_PISI, width/JAMCANS_WIDTH_STRETCH, height/JAMCANS_HEIGHT_STRETCH);

  // real fruits (for selection)
  image(strawIM, CAKE_ARVD_X-5, CAKE_ARVD_Y-70, width/7.5, height/3.5);
  image(blueIM, CAKE_ARVD_X+30, CAKE_ARVD_Y+150, width/10, height/7);
  image(mangoIM, CAKE_ARVD_X-5, CAKE_ARVD_Y+80, width/10, height/8);

 
 
 
  if (cake_arrived) // cream only put after the cake in the plate
  {
  
    if (cream_applied) //pipingbag arrived the cake plate
    {
      image(creamIM, CAKE_ARVD_X, CAKE_ARVD_Y); 
    } 
    else 
    {
      image(cakeIM, CAKE_ARVD_X, CAKE_ARVD_Y);  
    }

    //keypressed jam can,..--> put on cake
    if (jam_type == strawberry)      
      image(strawjamckIM, CAKE_ARVD_X, CAKE_ARVD_Y);
    else if (jam_type == blueberry) 
      image(bluejamckIM,  CAKE_ARVD_X, CAKE_ARVD_Y);
    else if (jam_type == mango) 
      image(mangojamckIM, CAKE_ARVD_X, CAKE_ARVD_Y);

   //click to choose the fruit type
    if (fruit_type == strawberry) 
      image(strawckIM, CAKE_ARVD_X, CAKE_ARVD_Y);
    else if (fruit_type == blueberry) 
      image(blueckIM,  CAKE_ARVD_X, CAKE_ARVD_Y);
    else if (fruit_type == mango)      
      image(mangockIM, CAKE_ARVD_X, CAKE_ARVD_Y);
 } 
 else //cake not be choosen, can only select fruit.(or can select fruit frist then drag cake)
 {
    image(cakeIM, cakeX, cakeY);
    if (fruit_type == strawberry) 
      image(strawckIM, CAKE_ARVD_X, CAKE_ARVD_Y + FRUITS_CK_Y_SHIFT);
    else if (fruit_type == blueberry) 
      image(blueckIM,  CAKE_ARVD_X, CAKE_ARVD_Y + FRUITS_CK_Y_SHIFT);
    else if (fruit_type == mango)      
      image(mangockIM, CAKE_ARVD_X, CAKE_ARVD_Y + FRUITS_CK_Y_SHIFT);
    
  }
  
  //at last, bc the pipingbag picture need cover(in front of) the cake. run order
  image(pipingbagIM, pipingbag_x, pipingbag_y, width/PIPINGBAG_WIDTH_STRETCH, height/PIPINGBAG_HEIGHT_STRETCH);

}

void mouseDragged() 
{
  //pipingbag dragged
  if (draggingPipingBag) 
  {
    pipingbag_x = mouseX - int(setX);
    pipingbag_y = mouseY - int(setY);

   
    if (cake_arrived) 
    {
      if (pipingbag_x > CAKE_ARVD_X && pipingbag_x< CAKE_ARVD_X + CAKE_WIDTH &&pipingbag_y  > CAKE_ARVD_Y && pipingbag_y  < CAKE_ARVD_Y + CAKE_HEIGHT) 
      {
        cream_applied = true;
      }
    }
  }

  //cake dragged
  if (mouseX >= width/2-150 && mouseX <= width/2+120 && mouseY >= height/2-20 && mouseY <= height/2+100) 
  {
    cake_arrived = true;
    cakeX = CAKE_ARVD_X;
    cakeY = CAKE_ARVD_Y;
  } 
  else 
  {
    if (!cake_arrived) 
    {
      cakeX = mouseX - 240;
      cakeY = mouseY - 90;
    }
  }
}

void mousePressed() 
{
   float bagW = width / PIPINGBAG_WIDTH_STRETCH;//  because the picture is out of the shape
   float bagH = height / PIPINGBAG_HEIGHT_STRETCH;//this calcu real size of the pic
   if (mouseX >= pipingbag_x && mouseX <= pipingbag_x + bagW && mouseY >= pipingbag_y && mouseY <= pipingbag_y + bagH) //mouse into the pipbg position
  {
    draggingPipingBag = true;
    setX = mouseX - pipingbag_x; //make the mouse(x,y) in the center of the pipbg
    setY = mouseY - pipingbag_y;
  }
  
  if (mouseX >= PINK_SM_PLATE_STARTX && mouseX <= PINK_SM_PLATE_ENDX && mouseY >= PINK_SM_PLATE_STARTY && mouseY <= PINK_SM_PLATE_ENDY) 
  {
    fruit_type = mango;
  }

  else if (mouseX >= CAKE_ARVD_X + 10 && mouseX <= CAKE_ARVD_X + 100 &&mouseY >= CAKE_ARVD_Y + 130 && mouseY <= CAKE_ARVD_Y + 230) 
  {
    fruit_type = blueberry;
  }

  else if (mouseX >= PINK_BIG_PLATE_STARTX && mouseX <= PINK_BIG_PLATE_ENDX && mouseY >= PINK_BIG_PLATE_ENDY && mouseY <= PINK_BIG_PLATE_STARTY) 
  {
    fruit_type = strawberry;
  }
 
}

void mouseReleased() 
{
  draggingPipingBag = false;

  if (!cake_arrived) //IF not drag CAke to the plate, will back to original place
  {
    cakeX = 300;
    cakeY = 55;
  }
}

void keyPressed() 
{  
  //add jam
  if (key == '1') 
    jam_type = strawberry;
  else if (key == '2') 
    jam_type = blueberry;
  else if (key == '3') 
    jam_type = mango;
   
  //clean all(reset)
  if(key == BACKSPACE) // i don't know why i cant use (key == DELETE)
                       //only key == backspace success
  {  
    //cake
     cakeX = 300;
     cakeY = 55;
     cake_arrived = false;
    //fruit
    fruit_type = 0;
    //jam
    jam_type = 0;
    //cream
    cream_applied = false;
  }
  
}
