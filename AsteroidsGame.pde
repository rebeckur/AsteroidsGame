//your variable declarations here
SpaceShip apollo;
Star[] sky;
ArrayList<Asteroid> groupAsteroids;
Bullet bang;

public void setup() 
{
  size(700,700);
  apollo = new SpaceShip();
  bang = new Bullet(apollo);
  groupAsteroids = new ArrayList<Asteroid>();
  sky = new Star[(int)(Math.random()*350)+300];
  for (int i = 0; i < sky.length; i++)
  {
    sky[i] = new Star();
  }
  for (int i = 0; i < (int)(Math.random()*9)+5; i++)
  {
    groupAsteroids.add(new Asteroid());
  }
  //System.out.println(groupAsteroids.size());
}
public void draw() 
{
  if (apollo.getLives() == 0)
  {
    apollo.setAlive(false);
  }
  if (apollo.getAlive() == true){
    background(0);
    for (int i = 0; i < sky.length; i++)
    {
      sky[i].show();
    }
    textSize(20);
    fill(255);
    text("Lives: " + apollo.getLives(), 40, 40);    
    apollo.move();
    apollo.show();
    bang.show();
    if (groupAsteroids.size() == 0) //checking to see if all asteroids destroyed while spacehip is still alive
      {
        background(0);
        textSize(32);
        stroke(255);
        fill(255);
        text("You win :)", 280, 300);
        strokeWeight(3);
        noFill();
        rect(260, 400, 200, 50);  
        text("RESTART", 290, 435);
        if (mousePressed && ((mouseX < 460 && mouseX > 260) && (mouseY < 450 && mouseY > 400)))
        {
          apollo.setAlive(true);
          apollo.setLives(3);
          for (int i = 0; i < groupAsteroids.size(); i++)
          {
            groupAsteroids.remove(i);
          }
          for (int i = 0; i < (int)(Math.random()*9)+5; i++)
          {
            groupAsteroids.add(new Asteroid());
          }
          apollo.setDirectionX(0);
          apollo.setDirectionY(0);
        } //restarts the game
      }
    for (int i = 0; i < groupAsteroids.size(); i++)
    {
      if (dist(apollo.getX(), apollo.getY(), (groupAsteroids.get(i)).getX(), (groupAsteroids.get(i)).getY()) < 20)
      {
        groupAsteroids.remove(i); //asteroid gets deleted
        apollo.setLives(apollo.getLives()-1); //reduces # of lives
      }
      else
      {
        (groupAsteroids.get(i)).move();
        (groupAsteroids.get(i)).show();
      }
    }
  }
  else //makes lose screen
  {
    background(0);
    textSize(32);
    fill(255);
    text("Try again", 280, 300);
    stroke(255);
    strokeWeight(3);
    noFill();
    rect(260, 400, 200, 50);  
    text("RESTART", 290, 435);
    if (mousePressed && ((mouseX < 460 && mouseX > 260) && (mouseY < 450 && mouseY > 400)))
    {
      apollo.setAlive(true);
      apollo.setLives(3);
      for (int i = 0; i < groupAsteroids.size(); i++)
      {
        groupAsteroids.remove(i);
      }
      for (int i = 0; i < (int)(Math.random()*9)+5; i++)
      {
        groupAsteroids.add(new Asteroid());
      }
      apollo.setDirectionX(0);
      apollo.setDirectionY(0);
    } //makes restart button
  }
}
public void keyPressed()
{
  if (keyCode == UP) {apollo.accelerate(0.9);}//accelerate
  if (keyCode == DOWN) {apollo.accelerate(-0.9);} //decelerate
  if (keyCode == LEFT) {apollo.rotate(-10);} //rotate left 
  if (keyCode == RIGHT) {apollo.rotate(10);} //rotate right 
  if (key == ENTER) //hyperspace
  {
    apollo.setX((int)(Math.random()*500)+50);
    apollo.setY((int)(Math.random()*500)+50);
    apollo.setPointDirection((int)(Math.random()*360));
    apollo.setDirectionX(0);
    apollo.setDirectionY(0);
  }
}
class Star
{
  private int starX, starY;
  public Star()
  {
    starX = (int)(Math.random()*700);
    starY = (int)(Math.random()*700);
  }
  public void show()
  {
    fill(255, 255, 255, 150);
    noStroke();
    ellipse(starX, starY, 2, 2);
  }
}
class SpaceShip extends Floater  
{
  private boolean alive;
  private int lives;
  public SpaceShip()
  {
    corners = 7;
    int[] xS = {8,-6,-7,-10,-10,-7,-6};
    int[] yS = {0,9,5,5,-5,-5,-9};
    xCorners = xS;
    yCorners = yS;
    myColor = color(156, 230, 220);
    myCenterX = 350;
    myCenterY = 350;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
    alive = true;
    lives = 3;
  }
  public void setX(int x){myCenterX = x;}  
  public int getX(){return (int)myCenterX;}   
  public void setY(int y){myCenterY = y;}   
  public int getY(){return (int)myCenterY;}   
  public void setDirectionX(double x){myDirectionX = x;}  
  public double getDirectionX(){return myDirectionX;}  
  public void setDirectionY(double y){myDirectionY = y;}   
  public double getDirectionY(){return myDirectionY;} 
  public void setPointDirection(int degrees){myPointDirection = degrees;} 
  public double getPointDirection(){return myPointDirection;}
  public boolean getAlive(){return alive;}
  public void setAlive(boolean status){alive = status;}
  public int getLives(){return lives;}
  public void setLives(int num){lives = num;}
}
class Asteroid extends Floater
{
  private int rotSpeed;
  public Asteroid()
  {
    rotSpeed = (int)(Math.random()*11)-5;
    if(rotSpeed == 0)
    {
      rotSpeed = (int)(Math.random()*6)+2;
    } //making sure all the asteroids rotate
    if ((int)(Math.random()*2) == 0)
    {
      corners = 5;
      int[] xS = {-4, 1, -7, 9, 8};
      int[] yS = {-10, -3, 0, 7, -5};
      xCorners = xS;
      yCorners = yS;
    }
    else
    {
      corners = 9;
      int[] xS2 = {10, 6, 0, -8, -7, -3, -10, -1, 4};
      int[] yS2 = {0, -6, -10, -10, -3, -2, 2, 9, 7};
      xCorners = xS2;
      yCorners = yS2;
    } //random variations of an asteroid in the array
    myColor = color(255);
    myCenterX = (int)(Math.random()*700);
    myCenterY = (int)(Math.random()*700);
    myDirectionX = (int)(Math.random()*6)-2;
    myDirectionY = (int)(Math.random()*6)-2;
    if (myDirectionX == 0 && myDirectionY == 0)
    {
      myDirectionX = (int)(Math.random()*3)+1;
      myDirectionY = (int)(Math.random()*3)+1;
    } //making sure none of the asteroids are idle
    myPointDirection = 0;
    }
  public void move()
  {
    rotate(rotSpeed);
    super.move();
  }
  public void setX(int x){myCenterX = x;}  
  public int getX(){return (int)myCenterX;}   
  public void setY(int y){myCenterY = y;}   
  public int getY(){return (int)myCenterY;}   
  public void setDirectionX(double x){myDirectionX = x;}  
  public double getDirectionX(){return myDirectionX;}  
  public void setDirectionY(double y){myDirectionY = y;}   
  public double getDirectionY(){return myDirectionY;} 
  public void setPointDirection(int degrees){myPointDirection = degrees;} 
  public double getPointDirection(){return myPointDirection;}
}
class Bullet extends Floater
{
  private double dRadians;
  public Bullet(SpaceShip theShip)
  {
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + theShip.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + theShip.getDirectionY();
  }
  public void show()
  {
    fill(255);
    stroke(255);
    ellipse((int)myCenterX, (int)myCenterY, 3, 3);
  }
  public void setX(int x){myCenterX = x;}  
  public int getX(){return (int)myCenterX;}   
  public void setY(int y){myCenterY = y;}   
  public int getY(){return (int)myCenterY;}   
  public void setDirectionX(double x){myDirectionX = x;}  
  public double getDirectionX(){return myDirectionX;}  
  public void setDirectionY(double y){myDirectionY = y;}   
  public double getDirectionY(){return myDirectionY;} 
  public void setPointDirection(int degrees){myPointDirection = degrees;} 
  public double getPointDirection(){return myPointDirection;}
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();  
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x); 
  abstract public double getDirectionX();
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();
  abstract public void setPointDirection(int degrees); 
  abstract public double getPointDirection();

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians = myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()  //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 
