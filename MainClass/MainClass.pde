import saito.objloader.*;
final float GRAV_ACCEL = 40; // 100 units PER SECOND
float FLOOR_HEIGHT;
Player observer;
OBJModel environment;
void setup()
{
  size(800, 600, P3D);
  FLOOR_HEIGHT = height / 2.0;
  observer = new Player(new PVector(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0)));
  environment = new OBJModel(this, "environment.obj", "relative", TRIANGLES);
  environment.scale(100);
  environment.translateToCenter();
  environment.translate(new PVector(0, 0, 2000));
  camera();
}

void draw()
{
  observer.updatePos();
  translate(width / 2, height / 2, 0);
  background(0);
  environment.draw();
  println("x pos: " + observer.pos.x);
  println("y pos: " + observer.pos.y);
  println("z pos: " + observer.pos.z);
}

void mousePressed()
{
  observer.attemptJump();
}
