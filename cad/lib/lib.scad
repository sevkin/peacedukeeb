include <layout.scad>

module each_key(kk)
  for(k = kk)
    let(x = k[0] * KEY_BETWEEN, y = k[1] * KEY_BETWEEN)
      translate([x, y, 0])
        children();

module mirrored() {
  rotate(a = -HALF_TILT)
    translate([-HALF_GAP, 0, 0])
      mirror([1, 0, 0])
        children();
  rotate(a = HALF_TILT)
    translate([HALF_GAP, 0, 0])
      children();
}

module translated()
  let(delta = KEY_BETWEEN/2)
    translate([delta, delta, 0])
      children();

module outline(r, $fn)
  offset(r = -r, $fn = $fn)
    offset(r = 2 * r, $fn = $fn) // BUG if r undefined
      children();

module key_mount_hole()
  square(size = KEY_MOUNT, center = true);

module half_keys(add) {
  each_key(RIGHT_HAND_KEYS)
    children();
  each_key(add)
    children();
}

module keys(add)
  mirrored()
    translated()
      half_keys(add)
        children();

module bridge(br) {
  mirrored()
    translated()
      each_key(BRIDGE_ADD)
        children();
  polygon(br);
}
