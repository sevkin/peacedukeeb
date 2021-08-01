include <../lib/layout.scad>
use <../lib/plates.scad>
use <../lib/holes.scad>

translate([KEY_BETWEEN, 0, 0])
difference() {
  half_plate();
  half_holes_out(SCREW_HOLE);
}

translate([-KEY_BETWEEN, 0, 0])
  mirror([1, 0, 0])
    difference() {
      half_plate();
      half_holes_out(SCREW_HOLE);
    }

