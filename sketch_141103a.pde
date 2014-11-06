//****************Object Variables**************
RideAgents[] ride;
PImage background;
PrintWriter output;
Table baseTable;
PFont titleFont, textFont, kmFont, subtitleFont;
PGraphics routes;


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
float totalAnimationTime = 50000;
//float totalAnimationTime = 1.5*60*30*3;
float baseStartTime = 5000000000L;
float baseEndTime = 0;
float unixAnimationTime = 0;
float tint = 1;
float totalKm = 0;
float districtKm1, districtKm2, districtKm3, districtKm4, districtKm5, districtKm6, districtKm7, districtKm8, districtKm9, districtKm10;


//****************Color Variables***********
//color agentsColor = #00FF81;
//color agentsColor = #FF4054;
color agentsColor = #14C0CC;
color titleColor = #14C0CC;

void setup() {
  //textFont = createFont("ProximaNova-Reg.otf", 10);
  titleFont = createFont("PlayfairDisplay-BoldItalic.ttf", 28, true);
  kmFont = createFont("PlayfairDisplay-BoldItalic.ttf", 48, true);
  subtitleFont = createFont("PlayfairDisplay-BoldItalic.ttf", 14, true);
  textFont = createFont("PlayfairDisplay-BoldItalic.ttf", 10, true);

  size(1280, 720, "processing.core.PGraphicsRetina2D");
  //size(1280, 720);

  background(0);
  colorMode(HSB, 360, 100, 100, 100);
  //hint(ENABLE_RETINA_PIXELS);
  smooth(8);
  //frameRate(30);
  frameRate(60);
  background = loadImage("Barcelona_Satelite_02.png");
  routes = createGraphics(width, height);
  //image(background, 0, 0, width, height);
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
  districtKm1 = 0;
  districtKm2 = 0;
  districtKm3 = 0;
  districtKm4 = 0;
  districtKm5 = 0;
  districtKm6 = 0;
  districtKm7 = 0;
  districtKm8 = 0;
  districtKm9 = 0;
  districtKm10 = 0;

  //background(0);
  //tint(360, tint);
  //image(background, 0, 0, width, height);
  /*
  for (int i=0; i<ride.length; i++) {
    ride[i].plotRide();
    ride[i].plotStartPoint();
    ride[i].plotEndPoint();
    totalKm = totalKm + ride[i].currentDistance;
    if (ride[i].district_id == 1) {
      districtKm1 = districtKm1 + ride[i].currentDistance;
    }
    if (ride[i].district_id == 2) {
      districtKm2 = districtKm2 + ride[i].currentDistance;
    }    
    if (ride[i].district_id == 3) {
      districtKm3 = districtKm3 + ride[i].currentDistance;
    }    
    if (ride[i].district_id == 4) {
      districtKm4 = districtKm4 + ride[i].currentDistance;
    }    
    if (ride[i].district_id == 5) {
      districtKm5 = districtKm5 + ride[i].currentDistance;
    }    
    if (ride[i].district_id == 6) {
      districtKm6 = districtKm6 + ride[i].currentDistance;
    }    
    if (ride[i].district_id == 7) {
      districtKm7 = districtKm7 + ride[i].currentDistance;
    }    
    if (ride[i].district_id == 8) {
      districtKm8 = districtKm8 + ride[i].currentDistance;
    }    
    if (ride[i].district_id == 9) {
      districtKm9 = districtKm9 + ride[i].currentDistance;
    }    
    if (ride[i].district_id == 10) {
      districtKm10 = districtKm10 + ride[i].currentDistance;
    }
  }

  //**************Text************************
  noStroke();
  fill(titleColor);
  textAlign(LEFT, TOP);
  textFont(titleFont);
  text("Barcelona Cycle Challenge - 2014", 20, 20);
  stroke(titleColor);
  strokeWeight(0.75);
  line(20, 58, 20+textWidth("Barcelona Cycle Challenge - 2014"), 58);
  textAlign(LEFT, BOTTOM);
  textFont(kmFont);
  text(nfc(totalKm, 1), 140, 110);
  textFont(subtitleFont);
  text("Kilometers cycled:", 20, 80);
  text("District race:", 20, 135);
  noStroke();
  fill(titleColor);
  rect(20, 140, districtKm1, 8);
  rect(20, 150, districtKm2, 8);
  rect(20, 160, districtKm3, 8);
  rect(20, 170, districtKm4, 8);
  rect(20, 180, districtKm5, 8);
  rect(20, 190, districtKm6, 8);
  rect(20, 200, districtKm7, 8);
  rect(20, 210, districtKm8, 8);
  rect(20, 220, districtKm9, 8);
  rect(20, 230, districtKm10, 8);
  textAlign(LEFT, CENTER);
  textFont(textFont);
  text("1", 25+districtKm1, 140);
  text("2", 25+districtKm2, 150);
  text("3", 25+districtKm3, 160);
  text("4", 25+districtKm4, 170);
  text("5", 25+districtKm5, 180);
  text("6", 25+districtKm6, 191);
  text("7", 25+districtKm7, 200);
  text("8", 25+districtKm8, 212);
  text("9", 25+districtKm9, 220);
  text("10", 25+districtKm10, 230);
  */

  textAlign(RIGHT, BOTTOM);
  textFont(subtitleFont);
  text("Animation produced by Juan Francisco Saldarriaga - juanfrans@gmail.com", width-20, height-20);

  //**************************Transparency Drawing********************
  routes.beginDraw();
  for (int i=0; i<ride.length; i++) {
    ride[i].plotRoute();
  }
  routes.endDraw();
  routes.save("transparency_overlay/routes_test_"+frameCount+".png");

  if (frameCount > totalAnimationTime) {
    exit();
  } else {
    println("Frame count = "+frameCount);
  }
  //saveFrame("base_frames/animation_####.png");
  //println((frameCount*unixAnimationTime)/totalAnimationTime+" "+(baseEndTime-baseStartTime));
}

