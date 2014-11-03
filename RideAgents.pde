class RideAgents {

  //****************Properties****************
  int ride_index;
  PVector[] coordinates;

  //****************Constructor***************
  RideAgents(int rideIndex, PVector[] coordinatePairs) {
    coordinates = coordinatePairs;
  }

  //****************Functions****************
  void plotRide() {
    float waypointTime = totalAnimationTime/coordinates.length;
    int currentWaypoint;
    PVector firstPoint, secondPoint;
    float distX, distY;
    fill(35, 100, 100);
    noStroke();
    if (coordinates.length > 1) {
      currentWaypoint = floor(frameCount/waypointTime);
      if (currentWaypoint<coordinates.length-1) {
        println(coordinates.length+" "+floor(frameCount/waypointTime));
        firstPoint = coordinates[currentWaypoint];
        secondPoint = coordinates[currentWaypoint+1];
        distX = secondPoint.x - firstPoint.x;
        distY = secondPoint.y - firstPoint.y;
        ellipse(map(firstPoint.x+distX/frameCount%waypointTime, minX, maxX, 0, width), map(firstPoint.y+distY/frameCount%waypointTime, minY, maxY, 0, height), 1.5, 1.5);
      }
    }
  }
}

