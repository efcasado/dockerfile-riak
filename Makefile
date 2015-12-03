###========================================================================
### File: Makefile
###
### Author(s): Enrique Fernandez <efcasado@gmail.com>
###========================================================================
.PHONY: all render build run info


## Settings
##-------------------------------------------------------------------------
RIAK_VSNS     ?= 1.4.12 \
		   	 	 1.4.0  \
			 	 1.3.2  \
			 	 1.3.0  \
			 	 1.2.1  \
			 	 1.2.0
RIAK_VSN      ?= $(firstword $(RIAK_VSNS))


## docker.mk settings
##-------------------------------------------------------------------------
DKRMK_VSN     := 0.0.1
DKRMK_URL     := https://github.com/efcasado/docker.mk
DKRMK_VSN_URL := $(DKRMK_URL)/releases/download/$(DKRMK_VSN)/docker.mk

DKR_IMAGE     := riak
DKR_IMAGE_VSN ?= $(RIAK_VSN)-$(GIT_VSN)


## Macros
##-------------------------------------------------------------------------
GIT_VSN        := $(shell git describe --tags 2> /dev/null || echo dev)
RENDER_TARGETS := $(patsubst %,%/Dockerfile,$(RIAK_VSNS))
BUILD_TARGETS  := $(patsubst %,build-%,$(RIAK_VSNS))
CLEAN_TARGETS  := $(patsubst %,clean-%,$(RIAK_VSNS))


## Targets
##-------------------------------------------------------------------------
all: render build

render: $(RENDER_TARGETS)
%/Dockerfile:
	mkdir -p $*
	cp -R ./files/* $*
	mustache vars/$*.yml Dockerfile.in > $@

build: $(BUILD_TARGETS)
build-%: ; DKR_IMAGE_VSN="$*-$(GIT_VSN)" DKR_DOCKERFILE="$*" $(MAKE) dkr-build

run: dkr-run

clean: $(CLEAN_TARGETS)
clean-%: ; rm -rf $*

info: dkr-info

docker.mk: ; wget $(DOCKERMK_URL)

-include docker.mk
