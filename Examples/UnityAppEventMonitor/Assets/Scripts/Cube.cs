using UnityEngine;
using AppEventMonitor;

public class Cube : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        AppEventMonitorManager.OnKeyDown += OnKeyDown;

        Debug.Log("Start!!");
        AppEventMonitorManager.Start();
    }

    void OnDestroy()
    {
        Debug.Log("Stop!!");
        AppEventMonitorManager.Stop();
    }

    private void OnKeyDown(string key)
    {
        Debug.Log($"OnKeyDown: {key}");
    }
}