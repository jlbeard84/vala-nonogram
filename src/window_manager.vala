using GL;

namespace Nonogram 
{
    public class WindowManager
    {
        private bool has_error = false;
        private GLFW.Window main_window = null;

        public WindowManager()
        { }

        public void init()
        {
            // Init GLFW
            if(!GLFW.glinit())
            {
                has_error = true;
                throw new NonogramError.WINDOW_ERROR("");
            }

            // MacOS bullshit:
            GLFW.set_hint(GLFW.WindowHint.CONTEXT_VERSION_MAJOR, 4);
            GLFW.set_hint(GLFW.WindowHint.CONTEXT_VERSION_MINOR, 1);
            GLFW.set_hint(GLFW.WindowHint.OPENGL_FORWARD_COMPAT, GL_TRUE);
            GLFW.set_hint(GLFW.WindowHint.OPENGL_PROFILE, GLFW.OpenGLProfile.CORE);
            // Normal window setup:
            GLFW.set_hint_bool(GLFW.WindowHint.RESIZABLE, false); // no resize 
            GLFW.set_hint(GLFW.WindowHint.SAMPLES, 2);            // no AA

            main_window = new GLFW.Window(1280, 720, "Hello World", null, null);
            main_window.set_size(640, 400);
            main_window.make_context_current();
        }

        public bool is_window_active()
        {
            return !main_window.should_close && !has_error;
        }

        public void swap_buffers()
        {
            main_window.swap_buffers();
        }
    }
}