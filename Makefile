.PHONY: clean

LIBS := $(wildcard cad/lib/*.scad)
PARTS := $(wildcard cad/parts/*.scad)
KBDS := $(wildcard cad/*.scad)

BLUEPRINTS := $(notdir $(wildcard cad/blueprint/*.scad))
DXFS := $(addprefix out/dxf/, $(BLUEPRINTS:.scad=.dxf))

all: out/dxf/ ${DXFS}

clean:
	rm -rf out/

out/dxf/%.dxf: cad/blueprint/%.scad ${LIBS} ${PARTS} ${KBDS}
	openscad -o $@ $<

out/dxf/:
	mkdir -p out/dxf/
