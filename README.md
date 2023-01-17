# UnityAppEventMonitor

![Platform](https://img.shields.io/badge/platform-%20macOS%2012%2B-lightgrey.svg)
![Unity](https://img.shields.io/badge/unity-2020%2B-green.svg)
![Xode](https://img.shields.io/badge/xcode-xcode14-green.svg)

[Unity Native Plugin](https://docs.unity3d.com/Manual/NativePlugins.html) for [NSEvent.addGlobalMonitorForEvents](https://developer.apple.com/documentation/appkit/nsevent/1535472-addglobalmonitorforevents).  
Receive keyboard input even when Unity.app is in the background with no focus.  
This Plugin works only on macOS.
This GIF shows that unity can detect keys entered into TextEdit.

<img src="docs/videos/helloworld.gif" width="800">  

# Requirements
## Unity
* Unity 2020.X
* Unity 2021.X
* Unity 2022.X
* Unity 2022.2+ (Apple Silicon)

## Platforms
* macOS 12+ (Apple Silicon and Intel)

# Installation
Download [AppEventMonitor.unitypakcage](https://github.com/fuziki/UnityAppEventMonitor/releases/download/0.1.0/AppEventMonitor.unitypackage) from the release page and install it in your project.  
To allow monitoring of keyboard input in the background, you need to add Unity to Accessibility.  
Open `System Preferences` > `Security & Privacy` > `Privacy` > `Accessibility` and add `Unity.app`.  
(And `Unity Hub.app` if you use)  

<img src="docs/images/accessibility.png" width="600">  

# Feature
## Keyboard Events
- [x] key down
- [ ] key up
- [ ] modifier key

## Mouse Events
- [ ] left mouse down
- [ ] left mouse dragged
- [ ] left mouse up
- [ ] right mouse down
- [ ] right mouse dragged
- [ ] right mouse up
- [ ] mouse moved
- [ ] scroll wheel

## Touch Events
- [ ] begin gesture
- [ ] end gesture

# Usage

Include package.

```cs
using AppEventMonitor;
```

Add action.


```cs
private void OnKeyDown(string key)
{
    Debug.Log($"OnKeyDown: {key}");
}
AppEventMonitorManager.OnKeyDown += OnKeyDown;
```

Start monitoring.

```cs
AppEventMonitorManager.Start();
```

Stop monitoring.

```cs
AppEventMonitorManager.Stop();
```

Example

```cs
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
```

# Example Projects
- [Unity](Examples/UnityAppEventMonitor)  
- [Native](Examples/NativeExample)
