include <lib/layout.scad>
use <lib/lib.scad>
use <lib/plates.scad>
use <lib/cases.scad>
use <lib/holes.scad>
use <lib/pcb.scad>
use <parts/trackpoint.scad>

module top()
  difference() {
    plate();
    keys()
      key_mount_hole();
    holes_in(SCREW_HOLE);
    holes_bridge_in(SCREW_HOLE);
    translate_trackpoint() {
      trackpoint_mount_holes();
      trackpoint_hole();
    }
  }

module bottom()
  difference() {
    plate();
    holes_in(SCREW_HOLE);
    holes_bridge_in(SCREW_HOLE);
  }

SHiFT = 0.00;
// SHiFT = 5.00;

translate([0, 0, -1.5 - SHiFT * 0])
  color("Gold")
    linear_extrude(height = 1.5)
      top();

translate([0, 0, -1.5 - SHiFT * 1])
  translate_trackpoint()
    trackpoint();

translate([0, 0, -1.5 -8 - SHiFT * 2])
  color("GhostWhite", 0.5)
    linear_extrude(height = 8)
      case();

translate([0, 0, -1.5 -3 -1.6 -0.4 - SHiFT * 3.5])
  color("DarkRed")
  linear_extrude(height = 1.6)
    key_pcbs();

translate([0, 0, -1.5 -8 -1.5 - SHiFT * 4])
  color("Yellow")
    linear_extrude(height = 1.5)
      bottom();
