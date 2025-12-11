LEVEL = ../../..

PROG     = voronoi
INCLUDES = defines.h
CPPFLAGS = -DTORONTO
LDFLAGS  = -lm
ifdef LARGE_PROBLEM_SIZE
RUN_OPTIONS = 1000000 20 32 7
else
ifdef SMALL_PROBLEM_SIZE
RUN_OPTIONS = 10000 20 32 7
else
RUN_OPTIONS = 500000 20 32 7
ifeq ($(ARCH),XCore)
XCORE_TARGET_NEEDS_MEMORY := 64
endif
endif
endif
HASH_PROGRAM_OUTPUT = 1

include $(LEVEL)/Makefile.multisrc
include $(LEVEL)/Makefile.rds

