include <lib/layout.scad>
use <lib/lib.scad>
use <lib/plates.scad>
use <lib/cases.scad>
use <lib/holes.scad>
use <lib/pcb.scad>
use <parts/trackpoint.scad>

SCREW_NUT_HOLE = 2.9;
CASE_SCREW_HOLE = 3.1;
CASE_NUT_HOLE = 5.1;

SHiFT = 0.00;
// SHiFT = 25.00;

HULL_CASE_HOLES = [
  [3.50, 0.25],
  [5.75, 3.50],
  [0.75 + 1.5 * cos(HALF_TILT), 4.50 + 1.75 * sin(HALF_TILT)], // HACK empiric value
];

module hull_case_holes() {
  mirrored()
    translated()
      for(h = HULL_CASE_HOLES)
        let(x = h[0] * KEY_BETWEEN, y = h[1] * KEY_BETWEEN)
          translate([x, y, 0])
            children();

  // center bottom hole
  let(cy =
    (0.00 * KEY_BETWEEN + HALF_GAP) * sin(HALF_TILT) +
    (0.00 * KEY_BETWEEN) * cos(HALF_TILT))
      translate([0, cy, 0])
        children();
}

module case_top()
  difference() {
    hull_case();
    mirrored()
      translated() {
        half_plate_keys_cut();
        half_holes_out(SCREW_NUT_HOLE);
      }
    // holes_bridge_in(SCREW_NUT_HOLE);
    hull_case_holes()
      circle(CASE_SCREW_HOLE / 2, $fn=50);
    translate_trackpoint() {
      trackpoint_mount_holes();
      trackpoint_hole();
    }
  }

module case_middle()
  difference() {
    offset(r=1, $fn=50)
      hull_case();
    outline(r=-0.5, $fn=50)
      outline(r=0.6, $fn=50)
      union() {
        offset(r=-15, $fn=50)
          hull_case();
        mirrored()
          translated()
            half_pcb_contour();
      }
    hull_case_holes()
      circle(CASE_NUT_HOLE / 2, $fn=50);
    translate([0, 128, 0])
      union() {
        translate([0, 6.9046, 0])
          outline(0.5, $fn=50)
            union() {
              square([10.5, 1], true);
                translate([0,1,0])
                  square([13.5, 1], true);
            }

        square([8.5, 18], true);

        translate([0, -9.0046, 0])
          outline(0.5, $fn=50)
            union() {
              square([7.5, 1], true);
                translate([0,-1,0])
              square([10.5, 1], true);
            }

      }
  }

module case_bottom()
  difference() {
    hull_case();
    hull_case_holes()
      circle(CASE_NUT_HOLE / 2, $fn=50);
  }


translate([0, 0, -1.5 - SHiFT * 0])
  color("LightGrey")
    linear_extrude(height = 1.5)
      mirrored()
        translated()
          difference() {
            half_plate();
            half_holes_out(SCREW_HOLE);
          }

translate([0, 0, -1.5 -3 - SHiFT * 1])
  color("PaleGoldenrod")
    linear_extrude(height = 3)
      case_top();

translate([0, 0, -1.5 -3.0 - SHiFT * 2])
  translate_trackpoint()
    trackpoint();

translate([0, 0, -1.5 -3 -1.6 -0.4 - SHiFT * 3])
  color("DarkRed")
  linear_extrude(height = 1.6)
    key_pcbs();

translate([0, 0, -1.5 -3 -6 - SHiFT * 4])
  color("GhostWhite", 0.5)
    linear_extrude(height = 6)
      case_middle();

translate([0, 0, -1.5 -3 -6 -3 - SHiFT * 5])
  color("PaleGoldenrod")
    linear_extrude(height = 3)
      case_bottom();
