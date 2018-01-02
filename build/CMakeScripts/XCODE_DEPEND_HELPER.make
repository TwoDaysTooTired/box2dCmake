# DO NOT EDIT
# This makefile makes sure all linkable targets are
# up-to-date with anything they link to
default:
	echo "Do not invoke directly"

# Rules to remove targets that are older than anything to which they
# link.  This forces Xcode to relink the targets from scratch.  It
# does not seem to check these dependencies itself.
PostBuild.cbox.Debug:
PostBuild.glm_static.Debug: /Users/wusunquan/Documents/box/build/cbox/Debug/cbox
/Users/wusunquan/Documents/box/build/cbox/Debug/cbox:\
	/Users/wusunquan/Documents/box/build/glm/glm/Debug/libglm_static.a
	/bin/rm -f /Users/wusunquan/Documents/box/build/cbox/Debug/cbox


PostBuild.Box2D.Debug:
/Users/wusunquan/Documents/box/build/Box2D/Debug/libBox2D.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/Box2D/Debug/libBox2D.a


PostBuild.glew.Debug:
/Users/wusunquan/Documents/box/build/glew/Debug/libglew.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glew/Debug/libglew.a


PostBuild.glfw.Debug:
/Users/wusunquan/Documents/box/build/glfw/Debug/libglfw3.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glfw/Debug/libglfw3.a


PostBuild.imgui.Debug:
/Users/wusunquan/Documents/box/build/imgui/Debug/libimgui.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/imgui/Debug/libimgui.a


PostBuild.testbed.Debug:
PostBuild.Box2D.Debug: /Users/wusunquan/Documents/box/build/testbed/Debug/testbed
PostBuild.glew.Debug: /Users/wusunquan/Documents/box/build/testbed/Debug/testbed
PostBuild.glfw.Debug: /Users/wusunquan/Documents/box/build/testbed/Debug/testbed
PostBuild.imgui.Debug: /Users/wusunquan/Documents/box/build/testbed/Debug/testbed
PostBuild.glm_static.Debug: /Users/wusunquan/Documents/box/build/testbed/Debug/testbed
/Users/wusunquan/Documents/box/build/testbed/Debug/testbed:\
	/Users/wusunquan/Documents/box/build/Box2D/Debug/libBox2D.a\
	/Users/wusunquan/Documents/box/build/glew/Debug/libglew.a\
	/Users/wusunquan/Documents/box/build/glfw/Debug/libglfw3.a\
	/Users/wusunquan/Documents/box/build/imgui/Debug/libimgui.a\
	/Users/wusunquan/Documents/box/build/glm/glm/Debug/libglm_static.a
	/bin/rm -f /Users/wusunquan/Documents/box/build/testbed/Debug/testbed


PostBuild.glm_static.Debug:
/Users/wusunquan/Documents/box/build/glm/glm/Debug/libglm_static.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glm/glm/Debug/libglm_static.a


PostBuild.cbox.Release:
PostBuild.glm_static.Release: /Users/wusunquan/Documents/box/build/cbox/Release/cbox
/Users/wusunquan/Documents/box/build/cbox/Release/cbox:\
	/Users/wusunquan/Documents/box/build/glm/glm/Release/libglm_static.a
	/bin/rm -f /Users/wusunquan/Documents/box/build/cbox/Release/cbox


PostBuild.Box2D.Release:
/Users/wusunquan/Documents/box/build/Box2D/Release/libBox2D.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/Box2D/Release/libBox2D.a


PostBuild.glew.Release:
/Users/wusunquan/Documents/box/build/glew/Release/libglew.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glew/Release/libglew.a


PostBuild.glfw.Release:
/Users/wusunquan/Documents/box/build/glfw/Release/libglfw3.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glfw/Release/libglfw3.a


PostBuild.imgui.Release:
/Users/wusunquan/Documents/box/build/imgui/Release/libimgui.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/imgui/Release/libimgui.a


PostBuild.testbed.Release:
PostBuild.Box2D.Release: /Users/wusunquan/Documents/box/build/testbed/Release/testbed
PostBuild.glew.Release: /Users/wusunquan/Documents/box/build/testbed/Release/testbed
PostBuild.glfw.Release: /Users/wusunquan/Documents/box/build/testbed/Release/testbed
PostBuild.imgui.Release: /Users/wusunquan/Documents/box/build/testbed/Release/testbed
PostBuild.glm_static.Release: /Users/wusunquan/Documents/box/build/testbed/Release/testbed
/Users/wusunquan/Documents/box/build/testbed/Release/testbed:\
	/Users/wusunquan/Documents/box/build/Box2D/Release/libBox2D.a\
	/Users/wusunquan/Documents/box/build/glew/Release/libglew.a\
	/Users/wusunquan/Documents/box/build/glfw/Release/libglfw3.a\
	/Users/wusunquan/Documents/box/build/imgui/Release/libimgui.a\
	/Users/wusunquan/Documents/box/build/glm/glm/Release/libglm_static.a
	/bin/rm -f /Users/wusunquan/Documents/box/build/testbed/Release/testbed


PostBuild.glm_static.Release:
/Users/wusunquan/Documents/box/build/glm/glm/Release/libglm_static.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glm/glm/Release/libglm_static.a


PostBuild.cbox.MinSizeRel:
PostBuild.glm_static.MinSizeRel: /Users/wusunquan/Documents/box/build/cbox/MinSizeRel/cbox
/Users/wusunquan/Documents/box/build/cbox/MinSizeRel/cbox:\
	/Users/wusunquan/Documents/box/build/glm/glm/MinSizeRel/libglm_static.a
	/bin/rm -f /Users/wusunquan/Documents/box/build/cbox/MinSizeRel/cbox


PostBuild.Box2D.MinSizeRel:
/Users/wusunquan/Documents/box/build/Box2D/MinSizeRel/libBox2D.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/Box2D/MinSizeRel/libBox2D.a


PostBuild.glew.MinSizeRel:
/Users/wusunquan/Documents/box/build/glew/MinSizeRel/libglew.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glew/MinSizeRel/libglew.a


PostBuild.glfw.MinSizeRel:
/Users/wusunquan/Documents/box/build/glfw/MinSizeRel/libglfw3.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glfw/MinSizeRel/libglfw3.a


PostBuild.imgui.MinSizeRel:
/Users/wusunquan/Documents/box/build/imgui/MinSizeRel/libimgui.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/imgui/MinSizeRel/libimgui.a


PostBuild.testbed.MinSizeRel:
PostBuild.Box2D.MinSizeRel: /Users/wusunquan/Documents/box/build/testbed/MinSizeRel/testbed
PostBuild.glew.MinSizeRel: /Users/wusunquan/Documents/box/build/testbed/MinSizeRel/testbed
PostBuild.glfw.MinSizeRel: /Users/wusunquan/Documents/box/build/testbed/MinSizeRel/testbed
PostBuild.imgui.MinSizeRel: /Users/wusunquan/Documents/box/build/testbed/MinSizeRel/testbed
PostBuild.glm_static.MinSizeRel: /Users/wusunquan/Documents/box/build/testbed/MinSizeRel/testbed
/Users/wusunquan/Documents/box/build/testbed/MinSizeRel/testbed:\
	/Users/wusunquan/Documents/box/build/Box2D/MinSizeRel/libBox2D.a\
	/Users/wusunquan/Documents/box/build/glew/MinSizeRel/libglew.a\
	/Users/wusunquan/Documents/box/build/glfw/MinSizeRel/libglfw3.a\
	/Users/wusunquan/Documents/box/build/imgui/MinSizeRel/libimgui.a\
	/Users/wusunquan/Documents/box/build/glm/glm/MinSizeRel/libglm_static.a
	/bin/rm -f /Users/wusunquan/Documents/box/build/testbed/MinSizeRel/testbed


PostBuild.glm_static.MinSizeRel:
/Users/wusunquan/Documents/box/build/glm/glm/MinSizeRel/libglm_static.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glm/glm/MinSizeRel/libglm_static.a


PostBuild.cbox.RelWithDebInfo:
PostBuild.glm_static.RelWithDebInfo: /Users/wusunquan/Documents/box/build/cbox/RelWithDebInfo/cbox
/Users/wusunquan/Documents/box/build/cbox/RelWithDebInfo/cbox:\
	/Users/wusunquan/Documents/box/build/glm/glm/RelWithDebInfo/libglm_static.a
	/bin/rm -f /Users/wusunquan/Documents/box/build/cbox/RelWithDebInfo/cbox


PostBuild.Box2D.RelWithDebInfo:
/Users/wusunquan/Documents/box/build/Box2D/RelWithDebInfo/libBox2D.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/Box2D/RelWithDebInfo/libBox2D.a


PostBuild.glew.RelWithDebInfo:
/Users/wusunquan/Documents/box/build/glew/RelWithDebInfo/libglew.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glew/RelWithDebInfo/libglew.a


PostBuild.glfw.RelWithDebInfo:
/Users/wusunquan/Documents/box/build/glfw/RelWithDebInfo/libglfw3.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glfw/RelWithDebInfo/libglfw3.a


PostBuild.imgui.RelWithDebInfo:
/Users/wusunquan/Documents/box/build/imgui/RelWithDebInfo/libimgui.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/imgui/RelWithDebInfo/libimgui.a


PostBuild.testbed.RelWithDebInfo:
PostBuild.Box2D.RelWithDebInfo: /Users/wusunquan/Documents/box/build/testbed/RelWithDebInfo/testbed
PostBuild.glew.RelWithDebInfo: /Users/wusunquan/Documents/box/build/testbed/RelWithDebInfo/testbed
PostBuild.glfw.RelWithDebInfo: /Users/wusunquan/Documents/box/build/testbed/RelWithDebInfo/testbed
PostBuild.imgui.RelWithDebInfo: /Users/wusunquan/Documents/box/build/testbed/RelWithDebInfo/testbed
PostBuild.glm_static.RelWithDebInfo: /Users/wusunquan/Documents/box/build/testbed/RelWithDebInfo/testbed
/Users/wusunquan/Documents/box/build/testbed/RelWithDebInfo/testbed:\
	/Users/wusunquan/Documents/box/build/Box2D/RelWithDebInfo/libBox2D.a\
	/Users/wusunquan/Documents/box/build/glew/RelWithDebInfo/libglew.a\
	/Users/wusunquan/Documents/box/build/glfw/RelWithDebInfo/libglfw3.a\
	/Users/wusunquan/Documents/box/build/imgui/RelWithDebInfo/libimgui.a\
	/Users/wusunquan/Documents/box/build/glm/glm/RelWithDebInfo/libglm_static.a
	/bin/rm -f /Users/wusunquan/Documents/box/build/testbed/RelWithDebInfo/testbed


PostBuild.glm_static.RelWithDebInfo:
/Users/wusunquan/Documents/box/build/glm/glm/RelWithDebInfo/libglm_static.a:
	/bin/rm -f /Users/wusunquan/Documents/box/build/glm/glm/RelWithDebInfo/libglm_static.a




# For each target create a dummy ruleso the target does not have to exist
/Users/wusunquan/Documents/box/build/Box2D/Debug/libBox2D.a:
/Users/wusunquan/Documents/box/build/Box2D/MinSizeRel/libBox2D.a:
/Users/wusunquan/Documents/box/build/Box2D/RelWithDebInfo/libBox2D.a:
/Users/wusunquan/Documents/box/build/Box2D/Release/libBox2D.a:
/Users/wusunquan/Documents/box/build/glew/Debug/libglew.a:
/Users/wusunquan/Documents/box/build/glew/MinSizeRel/libglew.a:
/Users/wusunquan/Documents/box/build/glew/RelWithDebInfo/libglew.a:
/Users/wusunquan/Documents/box/build/glew/Release/libglew.a:
/Users/wusunquan/Documents/box/build/glfw/Debug/libglfw3.a:
/Users/wusunquan/Documents/box/build/glfw/MinSizeRel/libglfw3.a:
/Users/wusunquan/Documents/box/build/glfw/RelWithDebInfo/libglfw3.a:
/Users/wusunquan/Documents/box/build/glfw/Release/libglfw3.a:
/Users/wusunquan/Documents/box/build/glm/glm/Debug/libglm_static.a:
/Users/wusunquan/Documents/box/build/glm/glm/MinSizeRel/libglm_static.a:
/Users/wusunquan/Documents/box/build/glm/glm/RelWithDebInfo/libglm_static.a:
/Users/wusunquan/Documents/box/build/glm/glm/Release/libglm_static.a:
/Users/wusunquan/Documents/box/build/imgui/Debug/libimgui.a:
/Users/wusunquan/Documents/box/build/imgui/MinSizeRel/libimgui.a:
/Users/wusunquan/Documents/box/build/imgui/RelWithDebInfo/libimgui.a:
/Users/wusunquan/Documents/box/build/imgui/Release/libimgui.a:
