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
    start_time = startTime-baseStartTime;
    end_time = endTime-baseStartTime;
    district_id = district;
  }

  //****************Functions****************
  void plotRide() {
    if (distanceMeters > 0) {
      float currentFrame = 0;
      float totalFrames = map((end_time-start_time), 0, unixAnimationTime, 0, totalAnimationTime);
      if (map(frameCount, 0, totalAnimationTime, 0, unixAnimationTime) > start_time && map(frameCount, 0, totalAnimationTime, 0, unixAnimationTime) < end_time) {
        currentFrame = frameCount-(map(start_time, 0, unixAnimationTime, 0, totalAnimationTime));
        currentDistance = distanceMeters*currentFrame/totalFrames/1000;
        float rideTime = map((end_time - start_time), 0, unixAnimationTime, 0, totalAnimationTime);
        float waypointTime = rideTime/coordinates.length;
        int currentWaypoint;
        PVector firstPoint, secondPoint;
        float distX, distY;
        fill(agentsColor);
        noStroke();
        if (coordinates.length > 1) {
          currentWaypoint = floor(currentFrame/waypointTime);
          if (currentWaypoint<coordinates.length-1) {
            //println(coordinates.length+" "+floor(frameCount/waypointTime));
            firstPoint = coordinates[currentWaypoint];
            secondPoint = coordinates[currentWaypoint+1];
            distX = secondPoint.x - firstPoint.x;
            distY = secondPoint.y - firstPoint.y;
            ellipse(map(firstPoint.x+distX/currentFrame%waypointTime, minX, maxX, 0, width), map(firstPoint.y+distY/currentFrame%waypointTime, minY, maxY, 0, height), 4, 4);
          }
        }
      } else {
      }
    } else {
    }
  }
  void plotStartPoint() {
    if (distanceMeters > 0) {
      float lengthOfPoint = 30;
      float sizeOfPoint;
      float currentFramePoint = 0;
      float startFrame = map(start_time, 0, unixAnimationTime, 0, totalAnimationTime);
      if (map(frameCount, 0, totalAnimationTime, 0, unixAnimationTime) > start_time && map(frameCount, 0, totalAnimationTime, 0, unixAnimationTime) < start_time+map(lengthOfPoint, 0, totalAnimationTime, 0, unixAnimationTime)) {
        currentFramePoint = frameCount-startFrame;
        sizeOfPoint = .4 * currentFramePoint;
        PVector startPoint = coordinates[0];
        fill(agentsColor);
        ellipse(map(startPoint.x, minX, maxX, 0, width), map(startPoint.y, minY, maxY, 0, height), 8, 8);
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
      float lengthOfPoint = 30;
      float sizeOfPoint;
      float currentFramePoint = 0;
      float endFrame = map(end_time, 0, unixAnimationTime, 0, totalAnimationTime);
      if (map(frameCount, 0, totalAnimationTime, 0, unixAnimationTime) > end_time && map(frameCount, 0, totalAnimationTime, 0, unixAnimationTime) < end_time+map(lengthOfPoint, 0, totalAnimationTime, 0, unixAnimationTime)) {
        currentFramePoint = frameCount-endFrame;
        sizeOfPoint = 0.4 * currentFramePoint;        
        PVector startPoint = coordinates[coordinates.length-1];
        fill(agentsColor);
        ellipse(map(startPoint.x, minX, maxX, 0, width), map(startPoint.y, minY, maxY, 0, height), 8, 8);
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
      float totalFrames = map((end_time-start_time), 0, unixAnimationTime, 0, totalAnimationTime);
      if (map(frameCount, 0, totalAnimationTime, 0, unixAnimationTime) > start_time && map(frameCount, 0, totalAnimationTime, 0, unixAnimationTime) < end_time) {
        currentFrame = frameCount-(map(start_time, 0, unixAnimationTime, 0, totalAnimationTime));
        currentDistance = distanceMeters*currentFrame/totalFrames/1000;
        float rideTime = map((end_time - start_time), 0, unixAnimationTime, 0, totalAnimationTime);
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

