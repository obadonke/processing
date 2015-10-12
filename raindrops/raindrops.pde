final int MAX_RAINDROPS = 100;
final int RATE = 100;
final int BRIGHTNESS = 70;
final int SATURATION = 100;
final int ALPHA_VALUE = 180;
final int HUE_START = 48;
final int HUE_RANGE = 60;
final int MAX_DROP_SIZE = 7;
final int MAX_DROP_SPEED = 5;

int nextRainDrop = 0;
int totalRainDrops = 0;

RainDrop[] drops = new RainDrop[MAX_RAINDROPS];

void setup()
{
  size(1920, 1080);
  colorMode(HSB,360,100,100);
  int complementHue = (HUE_START + HUE_RANGE/2 + 180) % 360;
  background(complementHue,100,15);
  print("Complement hue: "+ complementHue);
}

void draw()
{  
  for(int i = 0; i < totalRainDrops; ++i)
  {
    drops[i].update();
  }
  
  if (random(RATE) < 1) addRainDrop();

}

void addRainDrop()
{
  int x = int(random(width));
  RainDrop drop = new RainDrop(x);

  drops[nextRainDrop] = drop;
  ++nextRainDrop;
  drop.draw();
  
  if (nextRainDrop == MAX_RAINDROPS) nextRainDrop = 0;
  
  if (totalRainDrops < MAX_RAINDROPS) ++ totalRainDrops;
}

