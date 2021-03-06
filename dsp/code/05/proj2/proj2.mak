# Generated by the VisualDSP++ IDDE

# Note:  Any changes made to this Makefile will be lost the next time the
# matching project file is loaded into the IDDE.  If you wish to preserve
# changes, rename this file and run it externally to the IDDE.

# The syntax of this Makefile is such that GNU Make v3.77 or higher is
# required.

# The current working directory should be the directory in which this
# Makefile resides.

# Supported targets:
#     proj2_Debug
#     proj2_Debug_clean

# Define this variable if you wish to run this Makefile on a host
# other than the host that created it and VisualDSP++ may be installed
# in a different directory.

ADI_DSP=d:\Program Files\Analog Devices\VisualDSP 4.5


# $VDSP is a gmake-friendly version of ADI_DIR

empty:=
space:= $(empty) $(empty)
VDSP_INTERMEDIATE=$(subst \,/,$(ADI_DSP))
VDSP=$(subst $(space),\$(space),$(VDSP_INTERMEDIATE))

RM=cmd /C del /F /Q

#
# Begin "proj2_Debug" configuration
#

ifeq ($(MAKECMDGOALS),proj2_Debug)

proj2_Debug : ./Debug/proj2.dxe 

Debug/goetzel.doj :goetzel.c $(VDSP)/Blackfin/include/math.h $(VDSP)/Blackfin/include/yvals.h $(VDSP)/Blackfin/include/ymath.h $(VDSP)/Blackfin/include/math_bf.h $(VDSP)/Blackfin/include/fract_typedef.h $(VDSP)/Blackfin/include/fract_math.h $(VDSP)/Blackfin/include/ccblkfn.h $(VDSP)/Blackfin/include/stdlib.h $(VDSP)/Blackfin/include/stdlib_bf.h $(VDSP)/Blackfin/include/fr2x16_math.h $(VDSP)/Blackfin/include/fr2x16_base.h $(VDSP)/Blackfin/include/fr2x16_typedef.h $(VDSP)/Blackfin/include/r2x16_typedef.h $(VDSP)/Blackfin/include/raw_typedef.h $(VDSP)/Blackfin/include/r2x16_base.h goetzel.h $(VDSP)/Blackfin/include/stdio.h $(VDSP)/Blackfin/include/sys/stdio_bf.h 
	@echo ".\goetzel.c"
	$(VDSP)/ccblkfn.exe -c .\goetzel.c -file-attr ProjectName=proj2 -g -structs-do-not-overlap -no-multiline -double-size-32 -decls-strong -warn-protos -si-revision 0.5 -proc ADSP-BF533 -o .\Debug\goetzel.doj -MM

./Debug/proj2.dxe :$(VDSP)/Blackfin/ldf/ADSP-BF533.ldf $(VDSP)/Blackfin/lib/crtsf532.doj ./Debug/goetzel.doj $(VDSP)/Blackfin/lib/bf532_rev_0.5/__initsbsz532.doj $(VDSP)/Blackfin/lib/cplbtab533.doj $(VDSP)/Blackfin/lib/crtn532.doj $(VDSP)/Blackfin/lib/libsmall532.dlb $(VDSP)/Blackfin/lib/libio532.dlb $(VDSP)/Blackfin/lib/libc532.dlb $(VDSP)/Blackfin/lib/librt_fileio532.dlb $(VDSP)/Blackfin/lib/libevent532.dlb $(VDSP)/Blackfin/lib/libcpp532.dlb $(VDSP)/Blackfin/lib/libcpprt532.dlb $(VDSP)/Blackfin/lib/libx532.dlb $(VDSP)/Blackfin/lib/libf64ieee532.dlb $(VDSP)/Blackfin/lib/libdsp532.dlb $(VDSP)/Blackfin/lib/libsftflt532.dlb $(VDSP)/Blackfin/lib/libetsi532.dlb $(VDSP)/Blackfin/lib/libssl532.dlb $(VDSP)/Blackfin/lib/libdrv532.dlb $(VDSP)/Blackfin/lib/libprofile532.dlb 
	@echo "Linking..."
	$(VDSP)/ccblkfn.exe .\Debug\goetzel.doj -L .\Debug -flags-link -od,.\Debug -o .\Debug\proj2.dxe -proc ADSP-BF533 -si-revision 0.5 -MM

endif

ifeq ($(MAKECMDGOALS),proj2_Debug_clean)

proj2_Debug_clean:
	-$(RM) "Debug\goetzel.doj"
	-$(RM) ".\Debug\proj2.dxe"
	-$(RM) ".\Debug\*.ipa"
	-$(RM) ".\Debug\*.opa"
	-$(RM) ".\Debug\*.ti"
	-$(RM) ".\*.rbld"

endif


