# DO NOT EDIT
# This makefile makes sure all linkable targets are
# up-to-date with anything they link to
default:
	echo "Do not invoke directly"

# Rules to remove targets that are older than anything to which they
# link.  This forces Xcode to relink the targets from scratch.  It
# does not seem to check these dependencies itself.
PostBuild.glew.Debug:
/Users/wusunquan/Documents/box/build/glew/Debug/libglew.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glew/Debug/libglew.a


PostBuild.glew.Release:
/Users/wusunquan/Documents/box/build/glew/Release/libglew.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glew/Release/libglew.a


PostBuild.glew.MinSizeRel:
/Users/wusunquan/Documents/box/build/glew/MinSizeRel/libglew.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glew/MinSizeRel/libglew.a


PostBuild.glew.RelWithDebInfo:
/Users/wusunquan/Documents/box/build/glew/RelWithDebInfo/libglew.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glew/RelWithDebInfo/libglew.a




# For each target create a dummy ruleso the target does not have to exist
