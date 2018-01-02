# DO NOT EDIT
# This makefile makes sure all linkable targets are
# up-to-date with anything they link to
default:
	echo "Do not invoke directly"

# Rules to remove targets that are older than anything to which they
# link.  This forces Xcode to relink the targets from scratch.  It
# does not seem to check these dependencies itself.
PostBuild.imgui.Debug:
/Users/wusunquan/Documents/box/build/imgui/Debug/libimgui.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/imgui/Debug/libimgui.a


PostBuild.imgui.Release:
/Users/wusunquan/Documents/box/build/imgui/Release/libimgui.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/imgui/Release/libimgui.a


PostBuild.imgui.MinSizeRel:
/Users/wusunquan/Documents/box/build/imgui/MinSizeRel/libimgui.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/imgui/MinSizeRel/libimgui.a


PostBuild.imgui.RelWithDebInfo:
/Users/wusunquan/Documents/box/build/imgui/RelWithDebInfo/libimgui.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/imgui/RelWithDebInfo/libimgui.a




# For each target create a dummy ruleso the target does not have to exist
