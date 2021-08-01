include <layout.scad>
use <lib.scad>

RIGHT_HAND_HOLES_OUT_old = [
  "RT", "  ", "  ", "LT", "  ",
  "LT", "  ", "  ", "  ", "  ",
  "LB", "  ", "LB", "RB", "  ",
  "LT", "  ", "LB",
  "RT", "LT"
];

RIGHT_HAND_HOLES_OUT = [
  "  ", "LT", "  ", "RT", "  ",
  "  ", "  ", "  ", "  ", "  ",
  "LB", "  ", "  ", "  ", "LB",
  "LB", "  ", "RB",
  "  ", "RT"
];

RIGHT_HAND_HOLES_IN = [
  "  ", "  ", "  ", "  ", "  ",
  "RT", "  ", "  ", "LT", "  ",
  "  ", "  ", "  ", "  ", "RT",
  "RT", "  ", "  ",
  "  ", "  "
];

RIGHT_BRIDGE_HOLES_T_IN = [
  "  ", "  ", "  ", "  ", "  ",
  "  ", "  ", "  ", "  ", "  ",
  "  ", "  ", "  ", "  ", "  ",
  "  ", "  ", "  ",
  "  ", "  "
];

RIGHT_BRIDGE_HOLES_B_IN = [
  "  ", "  ", "  ", "  ", "  ",
  "  ", "  ", "  ", "  ", "  ",
  "  ", "  ", "  ", "  ", "  ",
  "  ", "  ", "  ",
  "  ", "  "
];

module _hole(k, dx, dy)
  let(x = k[0] * KEY_BETWEEN + dx, y = k[1] * KEY_BETWEEN + dy) {
    echo("hole", x, y);
    translate([x, y, 0])
      children();
  }

module each_hole(kk, hh, ox, oy)
  for(i = [0 : min(len(kk), len(hh)) -1])
    let(k = kk[i], h = hh[i])
      if( h == "LT") {
        _hole(k, - KEY_MOUNT / 2 - ox, KEY_MOUNT / 2 + oy)
          children();
      } else if( h == "RT") {
        _hole(k, KEY_MOUNT / 2 + ox, KEY_MOUNT / 2 + oy)
          children();
      } else if( h == "LB") {
        _hole(k, - KEY_MOUNT / 2 - ox, - KEY_MOUNT / 2 - oy)
          children();
      } else if( h == "RB") {
        _hole(k, KEY_MOUNT / 2 + ox, - KEY_MOUNT / 2 - oy)
          children();
      } else if( h == "TT") {
        _hole(k, 0, KEY_MOUNT / 2 + oy)
          children();
      } else if( h == "BB") {
        _hole(k, 0, - KEY_MOUNT / 2 - oy)
          children();
      } else if( h == "LL") {
        _hole(k, - KEY_MOUNT / 2 - ox, 0)
          children();
      } else if( h == "RR") {
        _hole(k, KEY_MOUNT / 2 + ox, 0)
          children();
      }

module half_holes(hh, ox, oy)
  each_hole(RIGHT_HAND_KEYS, hh, ox, oy)
    children();

module half_holes_out(d, $fn=FN)
  half_holes(RIGHT_HAND_HOLES_OUT, OUTLINE - HOLE_KEY_X_OFFSET, OUTLINE)
    circle(r = d / 2, $fn = $fn);

module half_holes_in(d, $fn=FN)
  half_holes(RIGHT_HAND_HOLES_IN, OUTLINE - HOLE_KEY_X_OFFSET, OUTLINE)
    circle(r = d / 2, $fn = $fn);

module half_holes_bridge_in(d, $fn=FN) {
  half_holes(RIGHT_BRIDGE_HOLES_T_IN, OUTLINE - HOLE_KEY_X_OFFSET, OUTLINE)
    circle(r = d / 2, $fn = $fn);
  half_holes(RIGHT_BRIDGE_HOLES_B_IN, OUTLINE - HOLE_KEY_X_OFFSET, OUTLINE)
    circle(r = d / 2, $fn = $fn);
}

module holes_in(d, $fn=FN)
  mirrored()
    translated()
      half_holes_in(d, $fn);

module holes_bridge_in(d, $fn=FN)
  mirrored()
    translated()
      half_holes_bridge_in(d, $fn);
