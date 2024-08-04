using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using System.Collections.Generic;
//i wanted to make minecraft on xna i never finshed it just managed to make one chunk 
namespace aCTUAL3D
{
    public class Game1 : Game
    {
        private GraphicsDeviceManager _graphics;
        Vector3 camTarget;        // Rotation
        Vector3 camPosition;      // Where cam is 
        Matrix projectionMatrix; // Takes 3d and turns into 2d
        Matrix viewMatrix;       // Position and orientation of the camera
        Matrix worldMatrix;      // Rotation and position of something in the world

        BasicEffect BasicEffect; // SpriteBatch for 3D

        // Geometric info  
        VertexBuffer vertexBuffer;
        IndexBuffer indexBuffer;

        public Game1()
        {
            _graphics = new GraphicsDeviceManager(this);
            Content.RootDirectory = "Content";

            _graphics.PreferredBackBufferWidth = 1920; // Width of the window
            _graphics.PreferredBackBufferHeight = 1080; // Height of the window
            _graphics.ApplyChanges(); // Apply the changes
        }

        protected override void Initialize()
        {
            base.Initialize();

            // Set up camera
            camTarget = new Vector3(0, 0, 0);
            camPosition = new Vector3(0, 0, -100f);

            projectionMatrix = Matrix.CreatePerspectiveFieldOfView(MathHelper.ToRadians(45f), GraphicsDevice.Viewport.AspectRatio, 1f, 1000f);
            viewMatrix = Matrix.CreateLookAt(camPosition, camTarget, Vector3.Up);
            worldMatrix = Matrix.CreateWorld(camTarget, Vector3.Forward, Vector3.Up);

            // BasicEffect
            BasicEffect = new BasicEffect(GraphicsDevice)
            {
                Alpha = 1.0f,
                VertexColorEnabled = true,
                LightingEnabled = false
            };

            // Initialize a list to hold all vertices and indices
            List<VertexPositionColor> vertexList = new List<VertexPositionColor>();
            List<short> indexList = new List<short>();

            short vertexBaseIndex = 0;
            int yoffset = 0;
            int zoffset = 0;

            for (int y = 0; y < 10; y++)
            {
                int xoffset = 0; // Reset xoffset for each new row along the y-axis
                for (int x = 0; x < 10; x++)
                {
                    for (int z = 0; z < 10; z++)
                    {
                        // Define the array to hold all vertex positions and colors for the current cube
                        VertexPositionColor[] cubeVertices = new VertexPositionColor[]
                        {
                            new VertexPositionColor(new Vector3(-20 + xoffset, 20 + yoffset, 0 + zoffset), Color.Red),    // 0: Front-top-left
                            new VertexPositionColor(new Vector3(20 + xoffset, 20 + yoffset, 0 + zoffset), Color.Green),   // 1: Front-top-right
                            new VertexPositionColor(new Vector3(20 + xoffset, -20 + yoffset, 0 + zoffset), Color.Blue),   // 2: Front-bottom-right
                            new VertexPositionColor(new Vector3(-20 + xoffset, -20 + yoffset, 0 + zoffset), Color.Yellow),// 3: Front-bottom-left
                            new VertexPositionColor(new Vector3(-20 + xoffset, 20 + yoffset, 40 + zoffset), Color.Cyan),  // 4: Back-top-left
                            new VertexPositionColor(new Vector3(20 + xoffset, 20 + yoffset, 40 + zoffset), Color.Magenta),// 5: Back-top-right
                            new VertexPositionColor(new Vector3(20 + xoffset, -20 + yoffset, 40 + zoffset), Color.Black), // 6: Back-bottom-right
                            new VertexPositionColor(new Vector3(-20 + xoffset, -20 + yoffset, 40 + zoffset), Color.White) // 7: Back-bottom-left
                        };

                        // Add the cube's vertices to the vertex list
                        vertexList.AddRange(cubeVertices);

                        // Define the indices for each triangle of the current cube
                        List<short> cubeIndicesList = new List<short>();

                        // Add additional values to the list
                        if (z == 0)
                            cubeIndicesList.AddRange(new short[]
                            {
                                // Front face
                                (short)(vertexBaseIndex + 0), (short)(vertexBaseIndex + 1), (short)(vertexBaseIndex + 2),
                                (short)(vertexBaseIndex + 0), (short)(vertexBaseIndex + 2), (short)(vertexBaseIndex + 3),
                            });

                        if (z == 9)
                        {
                            cubeIndicesList.AddRange(new short[]
                            {
                                // Back face
                                (short)(vertexBaseIndex + 4), (short)(vertexBaseIndex + 6), (short)(vertexBaseIndex + 5),
                                (short)(vertexBaseIndex + 4), (short)(vertexBaseIndex + 7), (short)(vertexBaseIndex + 6),
                            });
                        }

                        if (y == 9)
                        {
                            cubeIndicesList.AddRange(new short[]
                            {
                                // Top face
                                (short)(vertexBaseIndex + 0), (short)(vertexBaseIndex + 4), (short)(vertexBaseIndex + 5),
                                (short)(vertexBaseIndex + 0), (short)(vertexBaseIndex + 5), (short)(vertexBaseIndex + 1),
                            });
                        }

                        if (y == 0)
                        {
                            cubeIndicesList.AddRange(new short[]
                            {
                                // Bottom face
                                (short)(vertexBaseIndex + 3), (short)(vertexBaseIndex + 2), (short)(vertexBaseIndex + 6),
                                (short)(vertexBaseIndex + 3), (short)(vertexBaseIndex + 6), (short)(vertexBaseIndex + 7),
                            });
                        }

                        if (x == 0)
                        {
                            cubeIndicesList.AddRange(new short[]
                            {
                                // Left face
                                (short)(vertexBaseIndex + 0), (short)(vertexBaseIndex + 3), (short)(vertexBaseIndex + 7),
                                (short)(vertexBaseIndex + 0), (short)(vertexBaseIndex + 7), (short)(vertexBaseIndex + 4),
                            });
                        }

                        if (x == 9)
                        {
                            cubeIndicesList.AddRange(new short[]
                            {
                                // Right face
                                (short)(vertexBaseIndex + 1), (short)(vertexBaseIndex + 5), (short)(vertexBaseIndex + 6),
                                (short)(vertexBaseIndex + 1), (short)(vertexBaseIndex + 6), (short)(vertexBaseIndex + 2)
                            });
                        }

                        // Convert the list back to an array if needed
                        short[] cubeIndices = cubeIndicesList.ToArray();
                        // Add the cube's indices to the index list
                        indexList.AddRange(cubeIndices);

                        // Update the base index for the next cube
                        vertexBaseIndex += 8;

                        // Increment zoffset for the next cube along the z-axis
                        zoffset += 40;
                    }
                    // Reset zoffset and increment xoffset for the next column along the x-axis
                    zoffset = 0;
                    xoffset += 40;
                }
                // Reset xoffset and increment yoffset for the next row along the y-axis
                yoffset += 40;
            }

            // Create and set the vertex buffer data
            vertexBuffer = new VertexBuffer(GraphicsDevice, typeof(VertexPositionColor), vertexList.Count, BufferUsage.WriteOnly);
            vertexBuffer.SetData(vertexList.ToArray());

            // Create and set the index buffer data
            indexBuffer = new IndexBuffer(GraphicsDevice, IndexElementSize.SixteenBits, indexList.Count, BufferUsage.WriteOnly);
            indexBuffer.SetData(indexList.ToArray());
        }

        protected override void LoadContent()
        {
            // Load your content here
        }

        protected override void Update(GameTime gameTime)
        {
            KeyboardState keyboardState = Keyboard.GetState();

            if (keyboardState.IsKeyDown(Keys.Right))
            {
                camPosition.X -= 1f;
                camTarget.X -= 1f;
            }
            if (keyboardState.IsKeyDown(Keys.Left))
            {
                camPosition.X += 1f;
                camTarget.X += 1f;
            }
            if (keyboardState.IsKeyDown(Keys.Up))
            {
                camPosition.Y -= 1f;
                camTarget.Y -= 1f;
            }
            if (keyboardState.IsKeyDown(Keys.Down))
            {
                camPosition.Y += 1f;
                camTarget.Y += 1f;
            }
            if (keyboardState.IsKeyDown(Keys.OemPlus))
            {
                camPosition.Z += 1f;
            }
            if (keyboardState.IsKeyDown(Keys.OemMinus))
            {
                camPosition.Z -= 1f;
            }

            // Update the view matrix after changing camera position
            viewMatrix = Matrix.CreateLookAt(camPosition, camTarget, Vector3.Up);

            base.Update(gameTime);
        }

        protected override void Draw(GameTime gameTime)
        {
            BasicEffect.Projection = projectionMatrix;
            BasicEffect.View = viewMatrix;
            BasicEffect.World = worldMatrix;

            GraphicsDevice.Clear(Color.CornflowerBlue);

            GraphicsDevice.SetVertexBuffer(vertexBuffer);
            GraphicsDevice.Indices = indexBuffer;

            RasterizerState rasterizerState = new RasterizerState
            {
                CullMode = CullMode.None
            };
            GraphicsDevice.RasterizerState = rasterizerState;

            GraphicsDevice.SetVertexBuffer(vertexBuffer);
            GraphicsDevice.Indices = indexBuffer;

            // Apply the BasicEffect
            foreach (var pass in BasicEffect.CurrentTechnique.Passes)
            {
                pass.Apply();

                // Draw all cubes
                GraphicsDevice.DrawIndexedPrimitives(PrimitiveType.TriangleList, 0, 0, vertexBuffer.VertexCount, 0, indexBuffer.IndexCount / 3);
            }

            base.Draw(gameTime);
        }
    }
}
