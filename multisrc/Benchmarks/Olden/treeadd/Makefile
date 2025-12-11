LEVEL = ../../..

PROG       = treeadd
CPPFLAGS   = -DTORONTO
LDFLAGS    = 

ifdef SMALL_PROBLEM_SIZE
RUN_OPTIONS = 20
else
RUN_OPTIONS = 26
ifeq ($(ARCH),XCore)
XCORE_TARGET_NEEDS_MEMORY := 128
endif
endif

include $(LEVEL)/Makefile.multisrc
include $(LEVEL)/Makefile.rds


