//****************Object Variables**************
RideAgents[] ride;
PImage background;

//****************Global Variables**************
int numberOfRides = 4428;
//float minX = 2.007325263;
//float minY = 41.47392334;
//float maxX = 2.291591537;
//float maxY = 41.31402356;
float minX = 2.04793473;
float minY = 41.451080514;
float maxX = 2.25098207;
float maxY = 41.336866383;
float totalAnimationTime = 500;
//float totalAnimationTime = 1.5*60*30;

void setup() {
  size(1280, 720);
  background(0);
  colorMode(HSB, 360, 100, 100, 100);
  hint(ENABLE_RETINA_PIXELS);
  smooth(8);
  frameRate(30);
  background = loadImage("Barcelona_Satelite_02.png");
  loadData();
  println("All done...");
  //exit();
}

void loadData() {
  numberOfRides = 4000;
  ride = new RideAgents[numberOfRides];
  int rideIndex = 0;
  for (int i = 0; i<numberOfRides; i++) {
    rideIndex = i;
    float lng, lat;
    JSONObject baseData;
    PVector[] coordinatePairs;
    try {
      baseData = loadJSONObject("Play_To_Ride_"+(i+1)+".json");
      JSONArray features = baseData.getJSONArray("features");
      JSONObject thisFeature = features.getJSONObject(2);
      JSONObject geometry = thisFeature.getJSONObject("geometry");
      JSONArray coordinates = geometry.getJSONArray("coordinates");
      coordinatePairs = new PVector[coordinates.size()];
      for (int j = 0; j<coordinates.size (); j++) {
        JSONArray thisCoordinate = coordinates.getJSONArray(j);
        lng = thisCoordinate.getFloat(0);
        lat = thisCoordinate.getFloat(1);
        coordinatePairs[j] = new PVector();
        coordinatePairs[j].x = lng;
        coordinatePairs[j].y = lat;
      }
    } 
    catch (Exception e) {
      coordinatePairs = new PVector[1];
      coordinatePairs[0] = new PVector();
      coordinatePairs[0].x = 0;
      coordinatePairs[0].y = 0;
    }
    ride[i] = new RideAgents(rideIndex, coordinatePairs);
  }
  println("Done building the objects...");
}

void draw() {
  colorMode(HSB, 360, 100, 100, 100);
  background(0);
  tint(360, 50);
  image(background, 0, 0, width, height);
  for (int i=0; i<ride.length; i++) {
    ride[i].plotRide();
  }
  if (frameCount > totalAnimationTime) {
    exit();
  } else {
    println("Frame count = "+frameCount);
  }
}

