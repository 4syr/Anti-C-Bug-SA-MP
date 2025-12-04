# Anti-C-Bug SA-MP

A lightweight and efficient filterscript for SA-MP servers to prevent C-Bug exploits using YSI Hooks system for maximum compatibility.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![SA-MP](https://img.shields.io/badge/SA--MP-0.3.7--R2+-blue.svg)](https://sa-mp.mp)
[![Open.mp](https://img.shields.io/badge/open.mp-compatible-green.svg)](https://open.mp)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [How It Works](#how-it-works)
- [Configuration](#configuration)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

---

## 🎯 Overview

Anti-C-Bug SA-MP is a filterscript designed to maintain fair gameplay by preventing the "C-Bug" exploit. This exploit allows players to gain unfair advantages through rapid-fire manipulation on certain weapons like Desert Eagle, Shotgun, and Sniper Rifle.

Built using **YSI Hooks** system, this filterscript ensures maximum compatibility with existing gamemodes and other filterscripts without conflicts.

---

## ✨ Features

- ✅ **Exploit Detection**: Automatically detects and prevents C-Bug on Desert Eagle, Shotgun, and Sniper Rifle
- ⚡ **Lightweight**: Minimal impact on server performance
- 🔌 **Hook-Based**: Uses YSI Hooks for seamless integration without overriding callbacks
- 🎯 **High Compatibility**: Works with any gamemode without modification
- 🛠️ **Customizable**: Simple code structure for easy modification
- 🚀 **Production Ready**: Tested and reliable for live servers
- 🆕 **Open.mp Compatible**: Works on both SA-MP and open.mp

---

## 📦 Requirements

### Software Requirements
- **SA-MP Server**: Version 0.3.7-R2 or higher
- **Open.mp**: Compatible (optional)
- **Pawn Compiler**: Community compiler recommended

### Required Includes

This filterscript requires the following includes:

```pawn
#include <a_samp>           // Core SA-MP functions
#include <YSI_Coding\y_hooks> // YSI Hooks system
```

### Installing YSI Library

YSI (Y_Less' Script Includes) is a comprehensive library for SA-MP/Pawn scripting.

**Option 1: Using sampctl (Recommended)**
```bash
sampctl package install pawn-lang/YSI-Includes
```

**Option 2: Manual Installation**
1. Download YSI from: https://github.com/pawn-lang/YSI-Includes
2. Extract to `pawno/include/` directory
3. Ensure `YSI_Coding` folder exists in includes

**Option 3: Download Release**
- Get latest release: https://github.com/pawn-lang/YSI-Includes/releases
- Extract to your server's include folder

---

## 🚀 Installation

### Step 1: Install Dependencies

Ensure YSI Hooks is installed (see [Requirements](#requirements)).

### Step 2: Download Repository
```bash
git clone https://github.com/4syr/Anti-C-Bug-SA-MP.git
```

### Step 3: Copy Files
Copy `Anti-C-Bug.pwn` to your server's `filterscripts/` directory.

### Step 4: Compile
```bash
# Navigate to your server directory
cd /path/to/samp-server

# Compile using pawncc
pawncc -;+ -(+ filterscripts/Anti-C-Bug.pwn

# Or use pawno compiler
# Open pawno.exe → Open Anti-C-Bug.pwn → Press F5
```

### Step 5: Configure Server
Add the filterscript to `server.cfg`:
```cfg
filterscripts Anti-C-Bug
```

### Step 6: Restart Server
Restart your SA-MP server to activate the filterscript.

---

## ⚙️ How It Works

### YSI Hooks Implementation

This filterscript uses **YSI Hooks** instead of traditional callback overriding. This means:

- ✅ **No Conflicts**: Multiple scripts can use the same callbacks
- ✅ **Modular Design**: Easy to add/remove without gamemode modification
- ✅ **Automatic Integration**: Hooks execute before/after main callbacks

**Example Hook Usage:**
```pawn
hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    // C-Bug detection logic here
    if(IsCBugWeapon(weaponid))
    {
        // Check for suspicious firing patterns
        if(DetectCBugPattern(playerid, weaponid))
        {
            // Cancel shot or apply penalty
            return 0;
        }
    }
    return 1;
}
```

### Detection Method

The script monitors:
- Fire rate patterns for specific weapons
- Time between shots
- Player animation states
- Weapon change sequences

---

## 🔧 Configuration

### Server Configuration Example
```cfg
# server.cfg

# Server Settings
hostname Your Roleplay Server
maxplayers 100
gamemode0 yourgamemode 1

# Plugins
plugins sscanf streamer mysql crashdetect

# Filterscripts (load Anti-C-Bug first for best compatibility)
filterscripts Anti-C-Bug other_filterscripts

# Additional Settings
announce 1
rcon_password your_password
```

### Directory Structure
```
your-samp-server/
├── filterscripts/
│   ├── Anti-C-Bug.pwn
│   └── Anti-C-Bug.amx
├── pawno/
│   └── include/
│       ├── a_samp.inc
│       ├── YSI_Coding/
│       │   └── y_hooks.inc
│       └── YSI_Core/
│           └── (YSI dependencies)
├── plugins/
│   └── (your plugins)
└── server.cfg
```

### Customization

You can modify detection sensitivity in the script:

```pawn
// Adjust these values in the script
#define CBUG_MIN_SHOT_DELAY 100  // Minimum milliseconds between shots
#define CBUG_MAX_VIOLATIONS 3    // Maximum violations before action
#define CBUG_RESET_TIME 5000     // Reset counter after X milliseconds
```

---

## 🧪 Testing

After installation, verify the filterscript is working:

### 1. Server Console Check
```
[INFO] Filterscript 'Anti-C-Bug.amx' loaded.
```

### 2. In-Game Testing
1. **Connect** to your server
2. **Equip weapons**: Desert Eagle, Shotgun, or Sniper Rifle
3. **Test normal firing**: Should work normally
4. **Attempt C-Bug**: Rapid crouch-shoot should be prevented
5. **Monitor console**: Check for detection messages

### 3. Debug Mode (Optional)
Enable debug output by adding:
```pawn
#define CBUG_DEBUG
```
This will print detection events to server console.

### Troubleshooting

| Issue | Solution |
|-------|----------|
| **Compilation errors with YSI** | Ensure YSI is properly installed in `include/` folder |
| **"undefined symbol y_hooks"** | Download complete YSI package, not just y_hooks |
| **Script not loading** | Check server.cfg syntax and .amx file exists |
| **False positives** | Adjust `CBUG_MIN_SHOT_DELAY` value |
| **Not detecting C-Bug** | Increase sensitivity by lowering delay threshold |

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### How to Contribute

1. **Fork** the repository
2. **Create** a feature branch
   ```bash
   git checkout -b feature/improved-detection
   ```
3. **Make changes** and test thoroughly
4. **Commit** your changes
   ```bash
   git commit -m "Add: Improved detection for shotgun C-Bug"
   ```
5. **Push** to your fork
   ```bash
   git push origin feature/improved-detection
   ```
6. **Open** a Pull Request

### Contribution Guidelines
- ✅ Test changes on both SA-MP 0.3.7 and open.mp
- ✅ Maintain YSI Hooks compatibility
- ✅ Follow existing code style
- ✅ Update documentation for new features
- ✅ Include test results in PR description

### Reporting Issues
Found a bug? [Open an issue](https://github.com/4syr/Anti-C-Bug-SA-MP/issues) with:
- Server version (SA-MP/open.mp)
- YSI version
- Steps to reproduce
- Expected vs actual behavior

---

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

```
MIT License - Copyright (c) 2024 Muhammad Asyrafi Hidayatullah

Permission is hereby granted, free of charge, to use, modify, and distribute
this software for any purpose, commercial or non-commercial.
```

---

## 👨‍💻 Author

**Muhammad Asyrafi Hidayatullah**

[![GitHub](https://img.shields.io/badge/GitHub-4syr-181717?style=flat&logo=github)](https://github.com/4syr)

## 🙏 Credits

- **YSI Library**: [Y_Less & Contributors](https://github.com/pawn-lang/YSI-Includes)
- **SA-MP Team**: For the multiplayer mod
- **open.mp Team**: For continued development
- **Community**: For testing and feedback

---

## 📚 Additional Resources

- 📖 [YSI Documentation](https://github.com/pawn-lang/YSI-Includes/wiki)
- 🌐 [SA-MP Forums](https://forum.sa-mp.com)
- 💬 [open.mp Discord](https://discord.gg/samp)
- 🔧 [SA-MP Wiki](https://sampwiki.blast.hk)

---

## ⚠️ Disclaimer

- This filterscript specifically targets **C-Bug exploits only**
- Not a comprehensive solution for all cheats or exploits
- Effectiveness may vary based on gamemode and server configuration
- **Recommended**: Test in staging environment before production
- Server performance impact is minimal but should be monitored
- Some legitimate fast-clicking may be affected (configurable)

---

## 🔔 Updates & Changelog

### Version 1.0.0 (Latest)
- ✅ Initial release
- ✅ YSI Hooks implementation
- ✅ Desert Eagle, Shotgun, Sniper detection
- ✅ open.mp compatibility

*Check [Releases](https://github.com/4syr/Anti-C-Bug-SA-MP/releases) for detailed changelog*

---

<div align="center">

**Developed by Muhammad Asyrafi Hidayatullah**

Made with ❤️ for the SA-MP Community

[⬆ Back to Top](#anti-c-bug-sa-mp) | [Report Bug](https://github.com/4syr/Anti-C-Bug-SA-MP/issues) | [Request Feature](https://github.com/4syr/Anti-C-Bug-SA-MP/issues)

**Star ⭐ this repo if you find it helpful!**

</div>
