use <../lib/layout.scad>
use <../lib/lib.scad>
use <../lib/pcb.scad>
use <../lib/holes.scad>

KEY_MOUNT_OUT = 15.0; // keeb footprint
PCB_SCREW_HOLE = 3.2; // m2 standoff

difference(){
  half_pcb_contour();
  half_holes_in(PCB_SCREW_HOLE, 4);
  // io_pin_holes(4);
  // half_keys() {
    // square(size = KEY_MOUNT_OUT, center = true);
  // }
}
