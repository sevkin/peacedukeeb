include <layout.scad>
use <lib.scad>

module contour(ou, mount, br, add) {
  offset(r = ou, $fn = FN)
    keys(add)
      square(size = mount, center = true);
  outline(r = ou, $fn = FN)
    bridge(br)
      square(size = mount, center = true);
}

module plate()
  contour(ou = OUTLINE, mount = PLATE_MOUNT,
          br = BRIDGE_PLATE, add = RIGHT_HAND_PLATE_ADD);

module half_plate()
  difference() {
    offset(r = OUTLINE, $fn = FN)
      half_keys(RIGHT_HAND_PLATE_ADD)
        square(size = PLATE_MOUNT, center = true);
    half_keys()
      key_mount_hole();
  }

module half_plate_keys_cut()
  union() {
    offset(delta = (KEY_MOUNT - PLATE_MOUNT) / 2)
      half_keys(RIGHT_HAND_PLATE_ADD)
        square(size = PLATE_MOUNT, center = true);
    half_keys()
      square(size = [5, KEY_MOUNT + 1], center = true);
  }
