using GL;

namespace Nonogram 
{
    public class Game: Object
    {
        public Game() 
        { }

        public void run(GLFW.Window mainWindow) 
        {
            while(!mainWindow.should_close)
            {
                GLFW.poll_events(); // while not exit...

                glClearColor(0.2f, 0.2f, 0.2f, 1.0f);
                glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
                
                glDrawArrays(GL_TRIANGLES, 0, 3); // triangle, from vertex 0 to 3
                
                mainWindow.swap_buffers();
            }
        }
    }
}