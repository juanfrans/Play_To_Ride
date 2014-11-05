//****************Object Variables**************
RideAgents[] ride;
PImage background;
PrintWriter output;
Table baseTable;
PFont titleFont;
PFont kmFont;


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
float totalAnimationTime = 10000;
//float totalAnimationTime = 1.5*60*30;
float baseStartTime = 5000000000L;
float baseEndTime = 0;
float unixAnimationTime = 0;
int tint = 2;
color agentsColor = #8EFFC9;
float totalKm = 0;

void setup() {
  titleFont = createFont("ProximaNova-Reg.otf", 24);
  kmFont = createFont("ProximaNova-Bold.otf", 36);
  textFont(titleFont);
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
  //************************************************************Load table with other data
  baseTable = loadTable("p2r_report.csv", "header");

  //************************************************************Build list of json files
  java.io.File folder = new java.io.File(dataPath(""));
  java.io.FilenameFilter jsonFilter = new java.io.FilenameFilter() {
    public boolean accept(File dir, String name) {
      return name.toLowerCase().endsWith(".json");
    }
  };
  String[] filenames = folder.list(jsonFilter);

  //*************************************************************Loop through files
  numberOfRides = filenames.length;
  numberOfRides = 500;
  ride = new RideAgents[numberOfRides];
  int rideIndex = 0;
  String fileIndex;
  String[] fileNameComponents;
  float startTime, endTime, distance, district;
  String bikeShare;
  startTime = 5000000000L;
  endTime = 0;
  for (int i = 0; i<numberOfRides; i++) {
    fileNameComponents = split(filenames[i], "-");
    fileIndex = fileNameComponents[0];
    distance = 0;
    district = 0;
    bikeShare = null;
    for (TableRow row : baseTable.rows ()) {
      if (int(fileIndex) == int(row.getString("Id activitat"))) {
        startTime = float(row.getString("UnixStartTime"));
        endTime = float(row.getString("UnixEndTime"));
        distance = float(row.getString("Distancia de la activitat (m)"));
        district = float(row.getString("Districte id"));
        bikeShare = row.getString("Utiltiza bicing / Id bicing");
      } else {
      }
    }
    rideIndex = i;
    float lng, lat;
    JSONObject baseData;
    PVector[] coordinatePairs;
    try {
      baseData = loadJSONObject(filenames[i]);
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
    baseStartTime = min(startTime, baseStartTime);
    baseEndTime = max(endTime, baseEndTime);
    println("Building "+i+"/"+numberOfRides);
    ride[i] = new RideAgents(fileIndex, startTime, endTime, distance, district, bikeShare, rideIndex, coordinatePairs);
  }
  unixAnimationTime = baseEndTime - baseStartTime;
  println("Done building the objects...");
}

void draw() {
  colorMode(HSB, 360, 100, 100, 100);
  totalKm = 0;
  //background(0);
  //tint(360, tint);
  image(background, 0, 0, width, height);
  for (int i=0; i<ride.length; i++) {
    ride[i].plotRide();
    totalKm = totalKm + ride[i].currentDistance;
  }
  noStroke();
  fill(agentsColor);
  textAlign(LEFT, TOP);
  textFont(titleFont);
  text("BARCELONA CYCLE CHALLENGE - 2014", 20, 20);
  textFont(kmFont);
  text(nfc(totalKm, 1), 50, 50);
  if (frameCount > totalAnimationTime) {
    exit();
  } else {
    println("Frame count = "+frameCount);
  }
  //println((frameCount*unixAnimationTime)/totalAnimationTime+" "+(baseEndTime-baseStartTime));
}

