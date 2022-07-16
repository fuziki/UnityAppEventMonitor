using AOT;
using System;
using System.Runtime.InteropServices;
using UnityEngine;

#if UNITY_EDITOR_OSX
namespace AppEventMonitor
{
    public static class AppEventMonitorManager
    {
        // ------------------------------------------------------------------------------------------------------------------------- //
        [Serializable]
        class AppEventMonitorEvent
        {
            public string characters;
        }

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        private delegate void AppEventMonitor_CallbackType([MarshalAs(UnmanagedType.LPStr), In] string message);

        [DllImport("AppEventMonitor.bundle")]
        private static extern void AppEventMonitor_Start(string config, [MarshalAs(UnmanagedType.FunctionPtr)] AppEventMonitor_CallbackType callback);

        [MonoPInvokeCallback(typeof(AppEventMonitor_CallbackType))]
        private static void AppEventMonitor_CallbackTypeHandler(string message)
        {
            var e = JsonUtility.FromJson<AppEventMonitorEvent>(message);
            OnKeyDown.Invoke(e.characters);
        }

        [DllImport("AppEventMonitor.bundle")]
        private static extern void AppEventMonitor_Stop();
        // ------------------------------------------------------------------------------------------------------------------------- //

        /// <summary>
        /// Detect on key down.
        /// </summary>
        public static event Action<string> OnKeyDown;

        /// <summary>
        /// Start monitoring.
        /// </summary>
        public static void Start()
        {
            // detect keydown
            string config = "{ \"targets\" : 1024 }";
            AppEventMonitor_Start(config, AppEventMonitor_CallbackTypeHandler);
        }

        /// <summary>
        /// Stop monitoring.
        /// </summary>
        public static void Stop()
        {
            AppEventMonitor_Stop();
        }
    }
}
#endif