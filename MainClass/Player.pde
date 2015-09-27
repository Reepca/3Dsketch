class Player
{
  PVector pos; //initial position
  float initJumpVelocity; //in units per second
  long jumpStartTime = -1; //in milliseconds, will be -1 when not jumping.
  private float startYPos;
  private float startLookingAtY;
  PVector lookingAtPos;
  
  Player(PVector pos)
  {
    this.pos = pos;
    initJumpVelocity = -20;
  }
  
  Player(PVector pos, float initJumpVelocity)
  {
    this.pos = pos;
    this.initJumpVelocity = initJumpVelocity;
  }
  
  {
    lookingAtPos = new PVector(width / 2, height / 2, 0);
  }
  
  void attemptJump()
  {
    if(onSurface())
    {
      println("Starting jump! ");
      startYPos = pos.y;
      startLookingAtY = lookingAtPos.y;
      jumpStartTime = millis();
    }
  }
  
  void updatePos()
  {
    if(jumpStartTime != -1)
    {
      //Formula for calculating position under constant acceleration: startPosition + (time * averageVelocity)
      //averageVelocity = (startVelocity + (time * acceleration)) / 2
      float changeY = (float)(millis() - jumpStartTime) / 1000.0 * 
              (initJumpVelocity  + ( (float)(millis() - jumpStartTime) / 1000.0 * GRAV_ACCEL) / 2);
      pos.y = startYPos + changeY;
      lookingAtPos.y = startLookingAtY + changeY;
      if(jumpFinished())
      {
        println("Time elapsed: " + (millis() - jumpStartTime));
        jumpStartTime = -1;
        println("Jump finished!");
      }
    }
    camera(pos.x, pos.y, pos.z, lookingAtPos.x, lookingAtPos.y, lookingAtPos.z, 0, 1, 0);
  }
  
  boolean onSurface()
  {
    println("is on surface? " + (pos.y == FLOOR_HEIGHT));
    return pos.y == FLOOR_HEIGHT;
  }
  
  //jumpFinished is responsible for any side-effects of the jump finishing. 
  //For example, if the position was updated to be below the floor, this should correct it.
  boolean jumpFinished()
  {
    if(pos.y > FLOOR_HEIGHT)
    {
      lookingAtPos.y = startLookingAtY;
      pos.y = startYPos;
      return true;
    }
    return false;
  }
}
