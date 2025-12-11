LEVEL = ../../..

PROG     = perimeter
CPPFLAGS = -DTORONTO
LDFLAGS  = 
ifdef LARGE_PROBLEM_SIZE
RUN_OPTIONS = 11
else
ifdef SMALL_PROBLEM_SIZE
RUN_OPTIONS = 9
else
RUN_OPTIONS = 20
ifeq ($(ARCH),XCore)
XCORE_TARGET_NEEDS_MEMORY := 64
endif
endif
endif

include $(LEVEL)/Makefile.multisrc
include $(LEVEL)/Makefile.rds

