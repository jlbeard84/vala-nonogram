//using GLFW; // <- make sure you have this bad boy!
using GL;

namespace Nonogram 
{
    static int main(string[] args)
    {
        var window_manager = new WindowManager();
        window_manager.init();

        // create vertex attribute array 
        GLuint vao = 0; 
        glGenVertexArrays((GLsizei)1, (GLuint[])&vao);
        glBindVertexArray(vao); // <- from now on, glVertexAttribPointer points to vao
        
        const GLfloat vertices[] = {
            0.0f,  0.5f, // v1, x y 
            0.5f, -0.5f, // v2, x y 
            -0.5f,-0.5f  // v3, x y 
        };
        // create vertex buffer 
        GLuint vbuffer = 0;
        glGenBuffers(1, (GLuint[])&vbuffer);
        // and bind the triangle
        glBindBuffer(GL_ARRAY_BUFFER, vbuffer);
        glBufferData(GL_ARRAY_BUFFER, 
                    (GLsizeiptr)sizeof(GLfloat) * vertices.length, 
                    (GLvoid[])vertices, 
                    GL_STATIC_DRAW);
        
        // Load shader data from file
        Shader vs2 = new Shader("./shaders/simple.vs", GL_VERTEX_SHADER);
        Shader fs2 = new Shader("./shaders/simple.fs", GL_FRAGMENT_SHADER);
        
        // bind, link and attach the shaders
        GLuint shaderprog = glCreateProgram();
        glAttachShader(shaderprog, vs2.shader);
        glAttachShader(shaderprog, fs2.shader);
        glBindFragDataLocation(shaderprog, 0, "outColor");
        glLinkProgram(shaderprog);
        glUseProgram(shaderprog);
        
        // configure the shader to use n(x,y)f format 
        GLint posAttrib = glGetAttribLocation(shaderprog, "position");
        glEnableVertexAttribArray(posAttrib);
        glVertexAttribPointer(posAttrib, 
                            2, 
                            GL_FLOAT, 
                            (GLboolean)GL_FALSE, 
                            (GLsizei)(2 * sizeof(GLfloat)), 
                            null);
        
        try
        {
            // Main Loop 
            var game = new Game(window_manager);
            game.run();
        }
        catch (NonogramError e)
        {
            // do something?
        }

        // Cleanup:
        glDeleteProgram(shaderprog);
        
        // Shaders delete auto OK 
        
        //glDeleteBuffers(1, &ebo) element array buffer for later
        
        // delete the vertex buffer
        glDeleteBuffers(1, (GLuint[])&vbuffer);
        // delete this last because it holds the vertex attribute array. 
        glDeleteVertexArrays(1, (GLuint[])&vao);

        GLFW.glterminate();
        
        return 0;
    }
}
