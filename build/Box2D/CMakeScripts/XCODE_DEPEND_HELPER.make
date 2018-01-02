# DO NOT EDIT
# This makefile makes sure all linkable targets are
# up-to-date with anything they link to
default:
	echo "Do not invoke directly"

# Rules to remove targets that are older than anything to which they
# link.  This forces Xcode to relink the targets from scratch.  It
# does not seem to check these dependencies itself.
PostBuild.Box2D.Debug:
/Users/wusunquan/Documents/box/build/Box2D/Debug/libBox2D.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/Box2D/Debug/libBox2D.a


PostBuild.Box2D.Release:
/Users/wusunquan/Documents/box/build/Box2D/Release/libBox2D.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/Box2D/Release/libBox2D.a


PostBuild.Box2D.MinSizeRel:
/Users/wusunquan/Documents/box/build/Box2D/MinSizeRel/libBox2D.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/Box2D/MinSizeRel/libBox2D.a


PostBuild.Box2D.RelWithDebInfo:
/Users/wusunquan/Documents/box/build/Box2D/RelWithDebInfo/libBox2D.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/Box2D/RelWithDebInfo/libBox2D.a




# For each target create a dummy ruleso the target does not have to exist
