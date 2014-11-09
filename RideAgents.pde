class RideAgents {

  //****************Properties****************
  int ride_index;
  PVector[] coordinates;
  float distanceMeters;
  float start_time;
  float end_time;
  float currentDistance;
  float district_id;

  //****************Constructor***************
  RideAgents(String fileIndex, float startTime, float endTime, float distance, float district, String bikeShare, int rideIndex, PVector[] coordinatePairs) {
    coordinates = coordinatePairs;
    distanceMeters = distance;
    start_time = startTime;
    end_time = endTime;
    district_id = district;
  }

  //****************Functions****************
  void plotRide() {
    if (distanceMeters > 0) {
      float currentFrame = 0;
      float totalFrames = end_time - start_time;
      if (frameCount > start_time && frameCount < end_time) {
        currentFrame = frameCount-start_time;
        currentDistance = distanceMeters*currentFrame/totalFrames/1000;
        float rideTime = end_time - start_time;
        float waypointTime = rideTime/coordinates.length;
        int currentWaypoint;
        PVector firstPoint, secondPoint;
        float distX, distY;
        fill(agentsColor);
        noStroke();
        if (coordinates.length > 1) {
          currentWaypoint = floor(currentFrame/waypointTime);
          if (currentWaypoint<coordinates.length-1) {
            firstPoint = coordinates[currentWaypoint];
            secondPoint = coordinates[currentWaypoint+1];
            distX = secondPoint.x - firstPoint.x;
            distY = secondPoint.y - firstPoint.y;
            ellipse(map(firstPoint.x+distX/currentFrame%waypointTime, minX, maxX, 0, width), map(firstPoint.y+distY/currentFrame%waypointTime, minY, maxY, 0, height), 5, 5);
          }
        }
      } else {
      }
    } else {
    }
  }
  void plotStartPoint() {
    if (distanceMeters > 0) {
      float lengthOfPoint = 8;
      float sizeOfPoint;
      float currentFramePoint = 0;
      if (frameCount+3 > start_time && frameCount+3 < start_time+lengthOfPoint) {
        currentFramePoint = frameCount-start_time;
        sizeOfPoint = 1 * currentFramePoint;
        PVector startPoint = coordinates[0];
        fill(agentsColor);
        ellipse(map(startPoint.x, minX, maxX, 0, width), map(startPoint.y, minY, maxY, 0, height), 3, 3);
        stroke(agentsColor, 20);
        strokeWeight(.25);
        fill(agentsColor, 20);
        for (int i=0; i<5; i++) {
          ellipse(map(startPoint.x, minX, maxX, 0, width), map(startPoint.y, minY, maxY, 0, height), sizeOfPoint*i, sizeOfPoint*i);
        }
      }
    } else {
    }
  }
  void plotEndPoint() {
    if (distanceMeters > 0) {
      float lengthOfPoint = 20;
      float sizeOfPoint;
      float currentFramePoint = 0;
      if (frameCount > end_time && frameCount < end_time+lengthOfPoint) {
        currentFramePoint = frameCount-end_time;
        sizeOfPoint = 0.5 * currentFramePoint;        
        PVector startPoint = coordinates[coordinates.length-1];
        fill(agentsColor);
        ellipse(map(startPoint.x, minX, maxX, 0, width), map(startPoint.y, minY, maxY, 0, height), 5, 5);
        stroke(agentsColor, 20);
        strokeWeight(.25);
        fill(agentsColor, 20);
        for (int i=0; i<5; i++) {
          ellipse(map(startPoint.x, minX, maxX, 0, width), map(startPoint.y, minY, maxY, 0, height), sizeOfPoint*i, sizeOfPoint*i);
        }
      }
    } else {
    }
  }
  void plotRoute() {
    if (distanceMeters > 0) {
      float currentFrame = 0;
      float totalFrames = end_time-start_time;
      if (frameCount > start_time && frameCount < end_time) {
        currentFrame = frameCount-start_time;
        currentDistance = distanceMeters*currentFrame/totalFrames/1000;
        float rideTime = end_time - start_time;
        float waypointTime = rideTime/coordinates.length;
        int currentWaypoint;
        PVector firstPoint, secondPoint;
        float distX, distY;
        routes.fill(agentsColor, 10);
        routes.noStroke();
        if (coordinates.length > 1) {
          currentWaypoint = floor(currentFrame/waypointTime);
          if (currentWaypoint<coordinates.length-1) {
            firstPoint = coordinates[currentWaypoint];
            secondPoint = coordinates[currentWaypoint+1];
            distX = secondPoint.x - firstPoint.x;
            distY = secondPoint.y - firstPoint.y;
            routes.ellipse(map(firstPoint.x+distX/currentFrame%waypointTime, minX, maxX, 0, width), map(firstPoint.y+distY/currentFrame%waypointTime, minY, maxY, 0, height), 2, 2);
          }
        }
      } else {
      }
    } else {
    }
  }
}

