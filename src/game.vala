using GL;

namespace Nonogram 
{
    public class Game: Object
    {
        private WindowManager _window_manager;

        public Game(
            WindowManager window_manager) 
        { 
            _window_manager = window_manager;
        }

        public void run() 
        {
            while(_window_manager.is_window_active())
            {
                GLFW.poll_events(); // while not exit...

                glClearColor(0.2f, 0.2f, 0.2f, 1.0f);
                glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
                
                glDrawArrays(GL_TRIANGLES, 0, 3); // triangle, from vertex 0 to 3

                _window_manager.swap_buffers();
            }
        }
    }
}