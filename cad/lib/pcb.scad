include <layout.scad>
use <lib.scad>
use <holes.scad>

RIGHT_HAND_PCB_ADD = [
  [0.5, 1.5],
  [0.5, 1.00],
  [1.00, 1.00], [1.75, 1.00]
];

PCB_IO_HOLE = 0.8;
PCB_IO_HOLE_STEP = 2.54;
PCB_SCREW_HOLE = 3.2; // m2 standoff

CHERRY_MX_CENTER_HOLE = 4.1;
CHERRY_MX_EDGE_HOLE = 1.7;
CHERRY_MX_EDGE_OFFSET = 5.08;

CHERRY_MX_PIN_HOLE = 1.5;
CHERRY_MX_PINS_OFFSET = [[-3.81, 2.54], [2.54, 5.08]];

CHERRY_MX_LED_OFFSET = -5.05;

KAIHL_HOLE = 3;
KAIHL_BETWEEN = CHERRY_MX_PINS_OFFSET[1][0] - CHERRY_MX_PINS_OFFSET[0][0];
KAIHL_PAD = [2.5, 2.2];
KAIHL_PAD_OFFSET = (11 - KAIHL_BETWEEN) / 2;
KAIHL_PADS_OFFSET = [
  [CHERRY_MX_PINS_OFFSET[0][0] - KAIHL_PAD_OFFSET - KAIHL_PAD[0] / 2, CHERRY_MX_PINS_OFFSET[0][1]],
  [CHERRY_MX_PINS_OFFSET[1][0] + KAIHL_PAD_OFFSET + KAIHL_PAD[0] / 2, CHERRY_MX_PINS_OFFSET[1][1]],
];

LED_5050_SIZE = [5, 5];
LED_5050_PAD = [2, 1.2];
LED_5050_PAD_OFFSET = 0.5;

LED_2724_SIZE = [2.7, 2.4];
LED_2724_PAD = [0.8, 0.6];
LED_2724_PAD_OFFSET = 0.55/2;

module io_pin_holes($fn = FN)
  let(r = PCB_IO_HOLE / 2, dx = 3.3, of = 17.5, st = PCB_IO_HOLE_STEP) {
    // for (i = [0:2])
    //   let(dy = KEY_BETWEEN - of + i * st)
    //     translate([dx, dy])
    //       circle(r = r, $fn = $fn);
    for (i = [4:7])
      let(dy = KEY_BETWEEN - of + i * st)
        translate([dx, dy])
          circle(r = r, $fn = $fn);
    for (i = [9:13])
      let(dy = KEY_BETWEEN - of + i * st)
        translate([dx, dy])
          circle(r = r, $fn = $fn);
  }

module half_pcb_contour()
  outline(r = -0.01, $fn = FN)
    outline(r = 0.5, $fn = FN)
      difference() {
        offset(delta = (KEY_MOUNT - PLATE_MOUNT)/2+1.5)
          half_keys(RIGHT_HAND_PCB_ADD)
            square(size = PLATE_MOUNT, center = true);
      }

module half_pcb()
  difference() {
    half_pcb_contour();
    half_holes_in(PCB_SCREW_HOLE);
    io_pin_holes();
  }

module cherry_mx_mount_holes($fn = FN) {
  circle(r = CHERRY_MX_CENTER_HOLE / 2, $fn = $fn);
  translate([ CHERRY_MX_EDGE_OFFSET, 0, 0 ])
    circle(r = CHERRY_MX_EDGE_HOLE / 2, $fn = $fn);
  translate([ -CHERRY_MX_EDGE_OFFSET, 0, 0 ])
    circle(r = CHERRY_MX_EDGE_HOLE / 2, $fn = $fn);
}

module cherry_mx_pin_holes(r = CHERRY_MX_PIN_HOLE / 2, $fn = FN)
  for (pin = CHERRY_MX_PINS_OFFSET)
    translate(pin)
      circle(r = r);

module kailh_holes($fn = FN)
  cherry_mx_pin_holes(KAIHL_HOLE / 2, $fn);

module kailh_pads()
  for (pad = KAIHL_PADS_OFFSET)
    translate(pad)
      square(size = KAIHL_PAD, center = true);

module led_hole(sz)
  translate([0, CHERRY_MX_LED_OFFSET, 0])
    square(size = sz, center = true);

module led_pads(sz, pad, po)
  translate([0, CHERRY_MX_LED_OFFSET, 0])
    let(dx = (sz[0] + pad[0]) / 2, dy = (sz[1] - pad[1]) / 2 - po)
      for (t = [[dx, dy], [-dx, dy], [dx, -dy], [-dx, -dy]])
        translate(t)
          square(size = pad, center = true);

module key_pcb()
  difference() {
    half_pcb();
    half_keys() {
      cherry_mx_mount_holes();
      mirror([0, 1, 0]) {
        // front side
        // cherry_mx_pin_holes();
        kailh_holes();
        // back side
        mirror([1, 0, 0]) {
          // cherry_mx_pin_holes();
          kailh_holes();
        }
        // led_hole(LED_5050_SIZE);
        led_hole(LED_2724_SIZE);
      }
    }
  }

module key_pcbs()
  mirrored()
    translated()
      key_pcb();

module key_pcb_pads()
  half_keys()
    mirror([0, 1, 0]) {
        // front side
        kailh_pads();
      mirror([1, 0, 0])
        // back side
        color("green")
          kailh_pads();
      // all sides
      // led_pads(LED_5050_SIZE, LED_5050_PAD, LED_5050_PAD_OFFSET);
      led_pads(LED_2724_SIZE, LED_2724_PAD, LED_2724_PAD_OFFSET);
    }


color("darkred")
  key_pcb();

// translate([0, 0, 0.1])
//   key_pcb_pads();

color("gray")
  translate([0, 0, -0.1])
    half_keys()
      square(size = KEY_MOUNT_OUT, center = true);

// TODO add key diodes and led capacitators
