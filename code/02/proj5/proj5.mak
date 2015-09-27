# Generated by the VisualDSP++ IDDE

# Note:  Any changes made to this Makefile will be lost the next time the
# matching project file is loaded into the IDDE.  If you wish to preserve
# changes, rename this file and run it externally to the IDDE.

# The syntax of this Makefile is such that GNU Make v3.77 or higher is
# required.

# The current working directory should be the directory in which this
# Makefile resides.

# Supported targets:
#     proj5_Debug
#     proj5_Debug_clean

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
# Begin "proj5_Debug" configuration
#

ifeq ($(MAKECMDGOALS),proj5_Debug)

proj5_Debug : ./Debug/proj5.dxe 

./Debug/fir.doj :./fir.asm 
	@echo ".\fir.asm"
	$(VDSP)/easmblkfn.exe .\fir.asm -proc ADSP-BF533 -g -o .\Debug\fir.doj -MM

Debug/fir_test.doj :fir_test.c mds_def.h filter.h fir_coeff.h fir_input.h 
	@echo ".\fir_test.c"
	$(VDSP)/ccblkfn.exe -c .\fir_test.c -file-attr ProjectName=proj5 -g -structs-do-not-overlap -no-multiline -double-size-32 -decls-strong -warn-protos -proc ADSP-BF533 -o .\Debug\fir_test.doj -MM

./Debug/my_fir.doj :./my_fir.asm 
	@echo ".\my_fir.asm"
	$(VDSP)/easmblkfn.exe .\my_fir.asm -proc ADSP-BF533 -g -o .\Debug\my_fir.doj -MM

./Debug/proj5_basiccrt.doj :./proj5_basiccrt.s $(VDSP)/Blackfin/include/defBF532.h $(VDSP)/Blackfin/include/defBF533.h $(VDSP)/Blackfin/include/def_LPBlackfin.h $(VDSP)/Blackfin/include/sys/_adi_platform.h $(VDSP)/Blackfin/include/sys/anomaly_macros_rtl.h $(VDSP)/Blackfin/include/sys/platform.h 
	@echo ".\proj5_basiccrt.s"
	$(VDSP)/easmblkfn.exe .\proj5_basiccrt.s -proc ADSP-BF533 -g -o .\Debug\proj5_basiccrt.doj -MM

Debug/proj5_heaptab.doj :proj5_heaptab.c 
	@echo ".\proj5_heaptab.c"
	$(VDSP)/ccblkfn.exe -c .\proj5_heaptab.c -file-attr ProjectName=proj5 -g -structs-do-not-overlap -no-multiline -double-size-32 -decls-strong -warn-protos -proc ADSP-BF533 -o .\Debug\proj5_heaptab.doj -MM

./Debug/proj5.dxe :./Debug/my_fir.doj proj5.ldf ./Debug/proj5_basiccrt.doj $(VDSP)/Blackfin/lib/bf532_rev_0.3/libprofile532y.dlb ./Debug/fir.doj ./Debug/fir_test.doj ./Debug/proj5_heaptab.doj Debug/my_fir.doj $(VDSP)/Blackfin/lib/cplbtab533.doj $(VDSP)/Blackfin/lib/bf532_rev_0.3/crtn532y.doj $(VDSP)/Blackfin/lib/bf532_rev_0.3/libsmall532y.dlb $(VDSP)/Blackfin/lib/bf532_rev_0.3/libio532y.dlb $(VDSP)/Blackfin/lib/bf532_rev_0.3/libc532y.dlb $(VDSP)/Blackfin/lib/bf532_rev_0.3/libevent532y.dlb $(VDSP)/Blackfin/lib/bf532_rev_0.3/libx532y.dlb $(VDSP)/Blackfin/lib/bf532_rev_0.3/libcpp532y.dlb $(VDSP)/Blackfin/lib/bf532_rev_0.3/libcpprt532y.dlb $(VDSP)/Blackfin/lib/bf532_rev_0.3/libf64ieee532y.dlb $(VDSP)/Blackfin/lib/bf532_rev_0.3/libdsp532y.dlb $(VDSP)/Blackfin/lib/bf532_rev_0.3/libsftflt532y.dlb $(VDSP)/Blackfin/lib/bf532_rev_0.3/libetsi532y.dlb $(VDSP)/Blackfin/lib/bf532_rev_0.3/libssl532y.dlb $(VDSP)/Blackfin/lib/bf532_rev_0.3/libdrv532y.dlb $(VDSP)/Blackfin/lib/bf532_rev_0.3/idle532mty.doj $(VDSP)/Blackfin/lib/bf532_rev_0.3/librt_fileio532y.dlb 
	@echo "Linking..."
	$(VDSP)/ccblkfn.exe .\Debug\fir.doj .\Debug\fir_test.doj .\Debug\my_fir.doj .\Debug\proj5_basiccrt.doj .\Debug\proj5_heaptab.doj -T .\proj5.ldf -L .\Debug -flags-link -MDUSER_CRT=ADI_QUOTEproj5_basiccrt.dojADI_QUOTE,-MDUSE_FILEIO -flags-link -od,.\Debug -o .\Debug\proj5.dxe -proc ADSP-BF533 -flags-link -MM

endif

ifeq ($(MAKECMDGOALS),proj5_Debug_clean)

proj5_Debug_clean:
	-$(RM) ".\Debug\fir.doj"
	-$(RM) "Debug\fir_test.doj"
	-$(RM) ".\Debug\my_fir.doj"
	-$(RM) ".\Debug\proj5_basiccrt.doj"
	-$(RM) "Debug\proj5_heaptab.doj"
	-$(RM) ".\Debug\proj5.dxe"
	-$(RM) ".\Debug\*.ipa"
	-$(RM) ".\Debug\*.opa"
	-$(RM) ".\Debug\*.ti"
	-$(RM) ".\*.rbld"

endif


