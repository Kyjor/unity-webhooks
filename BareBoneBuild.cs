using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using UnityEditor;

namespace Assets.BuildScripts
{
    class BareBoneBuild
    {
        private static string[] scenes = { "Assets/Scenes/Level_0.unity"};

        static void PerformBuildWindows()
        {
            string[] args = System.Environment.GetCommandLineArgs ();
            string input = "";
            for (int i = 0; i < args.Length; i++) {
               //Debug.Log ("ARG " + i + ": " + args [i]);
                if (args [i] == "-executeMethod") {
                    input = args [i + 2];
                }
            }
            BuildPipeline.BuildPlayer(scenes, input + "/kyru.exe", BuildTarget.StandaloneWindows, BuildOptions.None);
        }
    

      static void PerformBuildWebGL()
        {
            string[] args = System.Environment.GetCommandLineArgs ();
            string input = "";
            for (int i = 0; i < args.Length; i++) {
                if (args [i] == "-executeMethod") {
                    input = args [i + 2];
                }
            }
            EditorUserBuildSettings.development = false;
            EditorUserBuildSettings.compressFilesInPackage = false;
            PlayerSettings.WebGL.linkerTarget = WebGLLinkerTarget.Wasm;
            BuildPipeline.BuildPlayer(scenes, input , BuildTarget.WebGL, BuildOptions.None);
        }

        static void PerformBuildOSX ()
        {
            string[] args = System.Environment.GetCommandLineArgs ();
            string input = "";
            for (int i = 0; i < args.Length; i++) {
                if (args [i] == "-executeMethod") {
                    input = args [i + 2];
                }
            }
                        BuildPipeline.BuildPlayer(scenes, input , BuildTarget.StandaloneOSX, BuildOptions.None);
        }
        static void PerformBuildLinux()
        {
            string[] args = System.Environment.GetCommandLineArgs ();
            string input = "";
            for (int i = 0; i < args.Length; i++) {
                if (args [i] == "-executeMethod") {
                    input = args [i + 2];
                }
            }
            BuildPipeline.BuildPlayer(scenes, input , BuildTarget.StandaloneLinux64, BuildOptions.None);
        }
    }
}