include <layout.scad>
use <lib.scad>
use <plates.scad>

module case()
  difference() {
    contour(ou = OUTLINE, mount = BOARD_MOUNT,
            br = BRIDGE_BOARD, add = RIGHT_HAND_BOARD_ADD);
    offset(r = -OUTLINE, $fn = FN)
      contour(ou = 0, mount = PLATE_MOUNT + PLATE_BOARD_LEDGE * 2,
              br = BRIDGE_BOARD, add = RIGHT_HAND_PLATE_ADD);
  }

module hull_case()
  offset(r=3, $fn=FN)
    offset(r=15, $fn=FN)
      offset(delta=-15)
        hull()
          case();
