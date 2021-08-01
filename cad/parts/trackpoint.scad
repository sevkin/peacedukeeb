include <../lib/layout.scad>

TRACKPOINT_OFFSET = 66; // HACK empiric value

module translate_trackpoint()
  translate([0, TRACKPOINT_OFFSET, 0])
    children();

module trackpoint_mount_holes()
  let(r = SCREW_HOLE/2, o = 18.9/2) {
    translate([-o, 0, 0])
      circle(r = r, $fn = FN);
    translate([o, 0, 0])
      circle(r = r, $fn = FN);
  }

module trackpoint_hole()
  circle(r = 9/2, $fn = FN);

module trackpoint() {
  color("Red")
  translate([0, 0, (7.4-2.8)/2], $fn = FN)
    cylinder(r=7.3/2, h=7.4-2.8, center=true);
  color("Gainsboro")
    difference() {
      translate([0, -30.2/2 + 7.5, 0])
        union() {
          translate([0, 5.0/2 -1.4, -0.2/2])
            cube(size = [26.4, 35.2, 0.2], center = true);
          translate([0, 0, -0.2/2])
            cube(size = [34.0, 30.2, 0.2], center = true);
          translate([0, 0, -2.8/2])
            cube(size = [26.4, 30.2, 2.8], center = true);
        }
      translate([0, 0, -2.81])
        linear_extrude(height = 2.82)
          trackpoint_mount_holes();
    }
}

difference() {
  trackpoint();
  translate([0, 0, -2.81])
    linear_extrude(height = 2.82)
      trackpoint_mount_holes();
}
