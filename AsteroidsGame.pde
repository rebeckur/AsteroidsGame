//your variable declarations here
SpaceShip apollo;

Star[] sky = new Star[300];

public void setup() 
{
  size(700,700);
  apollo = new SpaceShip();
  for (int i = 0; i < sky.length; i++)
  {
    sky[i] = new Star();
  }
}
public void draw() 
{
  background(0);
  for (int i = 0; i < sky.length; i++)
  {
    sky[i].show();
  }
  /*text("Y Center Direction: " + apollo.getY(), 0, 10);
  text("X Center Direction: " + apollo.getX(), 0, 20);
  text("X Direction: " + apollo.getDirectionX(), 0, 30);
  text("Y Direction: " + apollo.getDirectionY(), 0, 40);
  text("Spaceship Direction: " + apollo.getPointDirection(), 0, 50);*/ //Code to list out the positions
  apollo.move();
  apollo.show();
}
public void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == UP) //accelerate
    {
      apollo.accelerate(0.9);
      //need to fix so that lines coming out of spaceship are always behind it (angles!!)
      /*double angle = apollo.getPointDirection()*(Math.PI/180);
      int x1 = (int)(apollo.getX()-Math.cos(angle));
      int x2 = (int)(apollo.getX()-Math.cos(angle));
      stroke(255);
      line(x1, apollo.getY()-3, x2, apollo.getY()-5);
      line(x1, apollo.getY(), x2, apollo.getY());
      line(x1, apollo.getY()+3, x2, apollo.getY()+5);*/
    }
    if (keyCode == DOWN) {apollo.accelerate(-0.9);} //decelerate
    if (keyCode == LEFT) {apollo.rotate(-10);} //rotate left 
    if (keyCode == RIGHT) {apollo.rotate(10);} //rotate right 
  }
  if (keyCode == ' ') //hyperspace (spacebar)
    {
      apollo.setX((int)(Math.random()*500)+50);
      apollo.setY((int)(Math.random()*500)+50);
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
    fill(255, 255, 255, 130);
    noStroke();
    ellipse(starX, starY, 3, 3);
  }
}
class SpaceShip extends Floater  
{   
  public SpaceShip()
  {
    corners = 7;
    int[] xS = {8,-6,-7,-10,-10,-7,-6};
    int[] yS = {0,9,5,5,-5,-5,-9};
    xCorners = xS;
    yCorners = yS;
    myColor = color(0,100,200);
    myCenterX = 300;
    myCenterY = 300;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
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
  public void move ()   //move the floater in the current direction of travel
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

