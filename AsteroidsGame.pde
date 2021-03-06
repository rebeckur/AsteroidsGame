//your variable declarations here
SpaceShip apollo;
Star[] sky;
ArrayList<Asteroid> groupAsteroids;
ArrayList<LargeAsteroid> bigAsteroids;
ArrayList<Bullet> arsenal;
boolean goUp, goDown, goLeft, goRight;
ArrayList<HealthPack> health;
int score;
boolean cheatScore;

public void setup() 
{
  size(700,700);
  apollo = new SpaceShip();
  groupAsteroids = new ArrayList<Asteroid>();
  bigAsteroids = new ArrayList<LargeAsteroid>();
  arsenal = new ArrayList<Bullet>();
  sky = new Star[(int)(Math.random()*350)+300];
  health = new ArrayList<HealthPack>();
  for (int i = 0; i < sky.length; i++)
  {
    sky[i] = new Star();
  }
  for (int i = 0; i < (int)(Math.random()*5)+5; i++)
  {
    groupAsteroids.add(new Asteroid());
  }
  for (int i = 0; i < (int)(Math.random()*5)+2; i++)
  {
    bigAsteroids.add(new LargeAsteroid());
  }
  health.add(new HealthPack());
  //System.out.println(groupAsteroids);
  goUp = false;
  goDown = false;
  goLeft = false;
  goRight = false;
  score = 0;
  cheatScore = true;
}
public void draw() 
{
  background(0);
  if (apollo.getLives() < 1)
  {
    apollo.setAlive(false);
  }
  if (apollo.getAlive() == true) 
  { //runs the game when player has not died yet
    for (Star stars : sky)
    {
      stars.show();
    }
    textSize(20);
    fill(255);
    text("Lives: " + apollo.getLives(), 40, 40);
    text("Score: " + score, 550, 40);    
    apollo.move();
    apollo.show();
    if (goUp){apollo.accelerate(0.1);}              //allows users to press multiple 
    if (goDown){apollo.accelerate(-0.1);}           //keys at the same time to move and shoot
    if (goLeft){apollo.rotate(-5);}
    if (goRight){apollo.rotate(5);}
    if (health.size() > 0)
    {
      if (apollo.getLives() == 1)
      {
        health.get(0).show();
        //System.out.println("# of healths: " + health.size());
      }
      if (dist(apollo.getX(), apollo.getY(), health.get(0).getX(), health.get(0).getY()) < 15)
      {
        apollo.setLives(3);
        health.remove(0);
        bigAsteroids.add(new LargeAsteroid());
        //health.add(new HealthPack());
      } //if player gets the health pack
    }
    if (groupAsteroids.size() == 0 && bigAsteroids.size() == 0) //checking to see if all asteroids destroyed while spacehip is still alive
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
      textSize(20);
      text("Score: " + score, 300, 350);
      arsenal.clear(); //removes all bullets
      health.clear(); 
      if (mousePressed && ((mouseX < 460 && mouseX > 260) && (mouseY < 450 && mouseY > 400)))
      {
        apollo.setAlive(true);
        apollo.setLives(3);
        groupAsteroids.clear(); // removes all asteroids
        bigAsteroids.clear();
        for (int i = 0; i < (int)(Math.random()*9)+5; i++)
        {
          groupAsteroids.add(new Asteroid());
          bigAsteroids.add(new LargeAsteroid());
        }
        apollo.setDirectionX(0);
        apollo.setDirectionY(0);
        apollo.setX(350);     // positions ship back
        apollo.setY(350);     // to the center of the screen
        health.add(new HealthPack());
        score = 0;
      } //restarts the game
    }
    for (int i = 0; i < arsenal.size(); i++)
    {
      arsenal.get(i).move();
      arsenal.get(i).show();
    }//showing the bullets
    for (int i = 0; i < arsenal.size(); i++)
    {
      if (arsenal.get(i).getX() > 695 || arsenal.get(i).getX() < 5 || arsenal.get(i).getY() > 695 || arsenal.get(i).getY() < 5)
      {
        arsenal.remove(i);
        break;
      }
    }//removes the bullets that touch the sides of the screen
    for (int i = 0; i < bigAsteroids.size(); i++)
    {
      (bigAsteroids.get(i)).move();
      (bigAsteroids.get(i)).show();
      if (dist(apollo.getX(), apollo.getY(), (bigAsteroids.get(i)).getX(), (bigAsteroids.get(i)).getY()) < 30)
      {
        bigAsteroids.remove(i); //asteroid gets deleted
        apollo.setLives(apollo.getLives()-2); //reduces # of lives
        break;
      }
      for (int j = 0; j < arsenal.size(); j++)
      {
        if (dist(arsenal.get(j).getX(), arsenal.get(j).getY(), (bigAsteroids.get(i)).getX(), (bigAsteroids.get(i)).getY()) < 20)
        {
          score+=2;
          groupAsteroids.add(new Asteroid((bigAsteroids.get(i)).getX(), (bigAsteroids.get(i)).getY()));
          groupAsteroids.add(new Asteroid((bigAsteroids.get(i)).getX()+20, (bigAsteroids.get(i)).getY()));//smaller asteroids created
          bigAsteroids.remove(i); //asteroid gets deleted
          arsenal.remove(j); //bullet is removed
          break; //stops the loop from running, helped remove OutOfBoundsException error
        }
      } 
    }
    for (int i = 0; i < groupAsteroids.size(); i++)
    {
      (groupAsteroids.get(i)).move();
      (groupAsteroids.get(i)).show();
      if (dist(apollo.getX(), apollo.getY(), (groupAsteroids.get(i)).getX(), (groupAsteroids.get(i)).getY()) < 22)
      {
        groupAsteroids.remove(i); //asteroid gets deleted
        apollo.setLives(apollo.getLives()-1); //reduces # of lives
        break;
      }
      for (int j = 0; j < arsenal.size(); j++)
      {
        if (dist(arsenal.get(j).getX(), arsenal.get(j).getY(), (groupAsteroids.get(i)).getX(), (groupAsteroids.get(i)).getY()) < 20)
        {
          score++;
          groupAsteroids.remove(i); //asteroid gets deleted
          arsenal.remove(j); //bullet is removed
          break; //stops the loop from running, helped remove OutOfBoundsException error
        }
      } 
    }
  }
  if (apollo.getAlive() == false) //makes lose screen
  {
    textSize(32);
    fill(255);
    text("Try again", 280, 300);
    stroke(255);
    strokeWeight(3);
    noFill();
    rect(260, 400, 200, 50);  
    text("RESTART", 290, 435);
    textSize(20);
    text("Score: " + score, 300, 350);
    health.clear(); 
    if (mousePressed && ((mouseX < 460 && mouseX > 260) && (mouseY < 450 && mouseY > 400)))
    {
      apollo.setAlive(true);
      apollo.setLives(3);
      groupAsteroids.clear(); // removes all asteroids
      bigAsteroids.clear();
      for (int i = 0; i < (int)(Math.random()*9)+5; i++)
      {
        groupAsteroids.add(new Asteroid());
      }
      for (int i = 0; i < (int)(Math.random()*3)+1; i++)
      {
        bigAsteroids.add(i, new LargeAsteroid());
      }
      arsenal.clear(); //removes all bullets
      apollo.setDirectionX(0); //stops spaceship
      apollo.setDirectionY(0);
      apollo.setX(350);     // positions ship back
      apollo.setY(350);     // to the center of the screen
      health.add(new HealthPack());
      score = 0;
    } //makes restart button
  }
}
public void keyPressed()
{
  if (keyCode == UP) {goUp = true;/*apollo.accelerate(0.9);*/}
  if (keyCode == DOWN) {goDown = true;/*apollo.accelerate(-0.9);*/}
  if (keyCode == LEFT) {goLeft = true;/*apollo.rotate(-10);*/}
  if (keyCode == RIGHT) {goRight = true;/*apollo.rotate(10);*/} 
  if (key == ENTER) //hyperspace
  {
    apollo.setX((int)(Math.random()*500)+50);
    apollo.setY((int)(Math.random()*500)+50);
    apollo.setPointDirection((int)(Math.random()*360));
    apollo.setDirectionX(0);
    apollo.setDirectionY(0);
  }
  if (key == ' ')
  {
    arsenal.add(new Bullet(apollo));
    //System.out.println("# of bullets: " + arsenal.size());
  }

  //CHEATS :)
  if (key == 'r')
  {
    bigAsteroids.clear();
    score+=50;
  } //all big asteroids are gone and you get points!
  if (key == 's' && cheatScore)
  {
    score+=100;
    cheatScore = false;
  } //add 100 to the score only once!
}
public void keyReleased()
{
  if (keyCode == UP) {goUp = false;}
  if (keyCode == DOWN) {goDown = false;}
  if (keyCode == LEFT) {goLeft = false;}
  if (keyCode == RIGHT) {goRight = false;} 
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
  protected int rotSpeed;
  public Asteroid()
  {
    int n = 2;
    rotSpeed = (int)(Math.random()*11)-5;
    if(rotSpeed == 0)
    {
      rotSpeed = (int)(Math.random()*6)+2;
    } //making sure all the asteroids rotate
    if ((int)(Math.random()*2) == 0)
    {
      corners = 6;
      int[] xS = {-6, 3, -8, 5, 10, 8};
      int[] yS = {-10, -5, 0, 7, 9, -8};
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
    myColor = color(0);
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
  public Asteroid(int x, int y)
  {
    int n = 2;
    rotSpeed = (int)(Math.random()*11)-5;
    if(rotSpeed == 0)
    {
      rotSpeed = (int)(Math.random()*6)+2;
    } //making sure all the asteroids rotate
    if ((int)(Math.random()*2) == 0)
    {
      corners = 6;
      int[] xS = {-6, 3, -8, 5, 10, 8};
      int[] yS = {-10, -5, 0, 7, 9, -8};
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
    myColor = color(0);
    myCenterX = x;
    myCenterY = y;
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
  public void show()
  {
    strokeWeight(1);
    stroke(255);
    super.show();
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
class LargeAsteroid extends Asteroid
{ 
  public LargeAsteroid()
  {
    rotSpeed = (int)(Math.random()*9)-4;
    if(rotSpeed == 0)
    {
      rotSpeed = (int)(Math.random()*6)+2;
    } //making sure all the asteroids rotate
    corners = 7;
    int[] xS2 = {0, 21, 30, 24, 0, -20, -14};
    int[] yS2 = {-9, -21, 0, 21, 18, 5, -18};
    xCorners = xS2;
    yCorners = yS2;
    myColor = color(0);
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
    fill(255, 0, 0);
    stroke(255, 0, 0);
    ellipse((int)myCenterX, (int)myCenterY, 2, 2);
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
class HealthPack
{
  int packX, packY;
  int packColor;
  public HealthPack()
  {
    packX = (int)(Math.random()*660)+10;
    packY = (int)(Math.random()*660)+10;
    packColor = color(0, 150, 50);
  }
  public int getX(){return packX;}
  public int getY(){return packY;}
  public void show()
  {
    fill(packColor);
    stroke(packColor);
    rect(packX, packY, 10, 10, 2);
  }
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
    //stroke(myColor);    
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
