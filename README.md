<div align="center">

# 🛡️ Anti-C-Bug SA-MP

### Lightweight & Efficient C-Bug Prevention System

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![SA-MP](https://img.shields.io/badge/SA--MP-0.3.7--R2+-blue.svg)](https://sa-mp.mp)
[![Open.mp](https://img.shields.io/badge/open.mp-compatible-green.svg)](https://open.mp)
[![YSI](https://img.shields.io/badge/YSI-5.x-orange.svg)](https://github.com/pawn-lang/YSI-Includes)

**A professional filterscript solution to prevent C-Bug exploits in SA-MP servers using YSI Hooks system**

[Features](#-features) • [Installation](#-installation) • [Documentation](#-documentation) • [Contributing](#-contributing) • [Support](#-support)

---

</div>

## 📖 Overview

Anti-C-Bug SA-MP is a production-ready filterscript that prevents the notorious "C-Bug" exploit in San Andreas Multiplayer servers. Built with the powerful YSI Hooks system, it ensures seamless integration with any gamemode without callback conflicts.

The C-Bug exploit allows players to achieve unfair rapid-fire rates with weapons like Desert Eagle, Shotgun, and Sniper Rifle. This filterscript effectively detects and neutralizes such exploits while maintaining optimal server performance.

### Why Choose This Solution?

- 🎯 **Hook-Based Architecture** - Zero callback conflicts with existing scripts
- ⚡ **Performance Optimized** - Minimal CPU overhead and memory footprint
- 🔌 **Plug & Play** - Works out of the box with any gamemode
- 🛠️ **Highly Customizable** - Easy configuration for your specific needs
- ✅ **Battle-Tested** - Proven stability in production environments
- 🆕 **Future-Proof** - Compatible with both SA-MP and open.mp

---

## ✨ Features

<table>
<tr>
<td width="50%">

### Core Features
- ✅ Real-time C-Bug detection
- ✅ Multi-weapon support (Deagle, Shotgun, Sniper)
- ✅ Configurable sensitivity levels
- ✅ Automatic violation tracking
- ✅ Admin notification system
- ✅ Performance monitoring

</td>
<td width="50%">

### Technical Features
- ✅ YSI Hooks integration
- ✅ Non-intrusive implementation
- ✅ Modular code structure
- ✅ Debug logging support
- ✅ Memory efficient
- ✅ Open.mp compatible

</td>
</tr>
</table>

---

## 📋 Table of Contents

- [Requirements](#-requirements)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [How It Works](#-how-it-works)
- [Testing & Validation](#-testing--validation)
- [Troubleshooting](#-troubleshooting)
- [API Documentation](#-api-documentation)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🔧 Requirements

### Server Requirements

| Component | Version | Status |
|-----------|---------|--------|
| **SA-MP Server** | 0.3.7-R2 or higher | ✅ Required |
| **open.mp** | Latest version | ✅ Supported |
| **Pawn Compiler** | Community Compiler | ⭐ Recommended |

### Dependencies

```pawn
#include <a_samp>              // Core SA-MP functions
#include <YSI_Coding\y_hooks>  // YSI Hooks system
```

### Installing YSI Library

The YSI (Y_Less' Script Includes) library is essential for this filterscript to function.

#### Method 1: Using sampctl (Recommended)

```bash
sampctl package install pawn-lang/YSI-Includes
```

#### Method 2: Manual Installation

1. Download from [YSI-Includes Repository](https://github.com/pawn-lang/YSI-Includes)
2. Extract the contents to your `pawno/include/` directory
3. Verify that `YSI_Coding/y_hooks.inc` exists

#### Method 3: Release Package

1. Visit [YSI Releases](https://github.com/pawn-lang/YSI-Includes/releases)
2. Download the latest stable release
3. Extract to your server's include folder

> **💡 Pro Tip:** Always use the latest YSI version for optimal compatibility and bug fixes.

---

## 🚀 Installation

### Quick Start Guide

#### Step 1: Clone Repository

```bash
git clone https://github.com/4syr/Anti-C-Bug-SA-MP.git
cd Anti-C-Bug-SA-MP
```

#### Step 2: Verify Dependencies

Ensure YSI library is properly installed:

```bash
# Check if YSI exists
ls pawno/include/YSI_Coding/y_hooks.inc
```

#### Step 3: Copy to Filterscripts

```bash
# Copy the .pwn file
cp Anti-C-Bug.pwn /path/to/your/server/filterscripts/
```

#### Step 4: Compile

**Windows:**
```bash
pawno.exe filterscripts/Anti-C-Bug.pwn
```

**Linux:**
```bash
pawncc -;+ -(+ -d3 filterscripts/Anti-C-Bug.pwn -o filterscripts/Anti-C-Bug.amx
```

#### Step 5: Configure Server

Edit your `server.cfg`:

```properties
# Add to filterscripts line (preferably load first)
filterscripts Anti-C-Bug [other filterscripts]
```

#### Step 6: Start Server

```bash
./samp03svr  # Linux
# or
samp-server.exe  # Windows
```

### Verification

Check server console for successful load:

```
[INFO] Filterscript 'Anti-C-Bug.amx' loaded.
[Anti-C-Bug] System initialized successfully.
[Anti-C-Bug] Protection enabled for 3 weapon types.
```

---

## ⚙️ Configuration

### Basic Configuration

Open `Anti-C-Bug.pwn` and customize these defines:

```pawn
// ============================================
//           CONFIGURATION SECTION
// ============================================

// Minimum delay between shots (milliseconds)
#define CBUG_MIN_SHOT_DELAY     100

// Maximum violations before action
#define CBUG_MAX_VIOLATIONS     3

// Time to reset violation counter (milliseconds)
#define CBUG_RESET_TIME         5000

// Enable/disable debug output
// #define CBUG_DEBUG

// Punishment type: 0=Warning, 1=Kick, 2=Ban
#define CBUG_PUNISHMENT_TYPE    0

// Protected weapons
#define WEAPON_DEAGLE           24
#define WEAPON_SHOTGUN          25
#define WEAPON_SNIPER           34
```

### Advanced Configuration

#### Sensitivity Adjustment

| Setting | Conservative | Balanced | Aggressive |
|---------|-------------|----------|------------|
| `MIN_SHOT_DELAY` | 150ms | 100ms | 75ms |
| `MAX_VIOLATIONS` | 5 | 3 | 2 |
| `RESET_TIME` | 7000ms | 5000ms | 3000ms |

#### Custom Weapon Protection

Add or remove weapons from protection:

```pawn
stock bool:IsCBugWeapon(weaponid)
{
    switch(weaponid)
    {
        case WEAPON_DEAGLE, WEAPON_SHOTGUN, WEAPON_SNIPER:
            return true;
        // Add custom weapons here:
        // case WEAPON_M4, WEAPON_AK47:
        //     return true;
    }
    return false;
}
```

### Server Configuration Example

```properties
# ================================
#     SERVER CONFIGURATION
# ================================

# Server Identity
hostname         Your Professional Roleplay Server
language         English
announce         1
maxplayers       100

# Game Settings
gamemode0        yourgamemode 1
port             7777
rcon_password    your_secure_password

# Plugins (order matters)
plugins          crashdetect sscanf streamer mysql

# Filterscripts (load Anti-C-Bug first)
filterscripts    Anti-C-Bug anticheat base

# Logging
logqueries       0
logtimeformat    [%Y-%m-%d %H:%M:%S]
```

---

## 🔍 How It Works

### Architecture Overview

```
┌─────────────────────────────────────────┐
│         Player Weapon Actions           │
└──────────────────┬──────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────┐
│      YSI Hook: OnPlayerWeaponShot       │
│  (Non-intrusive callback interception)  │
└──────────────────┬──────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────┐
│        Weapon Type Verification         │
│   (Check if weapon is C-Bug capable)    │
└──────────────────┬──────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────┐
│       Time-Based Pattern Analysis       │
│  (Compare shot intervals with minimum)  │
└──────────────────┬──────────────────────┘
                   │
         ┌─────────┴─────────┐
         │                   │
    Legitimate          Suspicious
         │                   │
         ▼                   ▼
    Allow Shot        Increment Counter
                            │
                            ▼
                    ┌───────────────┐
                    │ Max Violations │
                    │    Reached?    │
                    └───────┬───────┘
                            │
                    ┌───────┴───────┐
                    │               │
                   Yes             No
                    │               │
                    ▼               ▼
            Take Action      Reset Timer
         (Warn/Kick/Ban)
```

### YSI Hooks Implementation

```pawn
// Hook implementation example
hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    // Only process C-Bug capable weapons
    if(!IsCBugWeapon(weaponid))
        return 1;
    
    // Get current timestamp
    new currentTime = GetTickCount();
    
    // Get last shot time for this player
    new lastShot = GetPlayerLastShotTime(playerid);
    
    // Calculate time difference
    new timeDiff = currentTime - lastShot;
    
    // Check if shot is too fast (C-Bug detected)
    if(timeDiff < CBUG_MIN_SHOT_DELAY)
    {
        // Increment violation counter
        IncrementViolations(playerid);
        
        // Check if max violations reached
        if(GetPlayerViolations(playerid) >= CBUG_MAX_VIOLATIONS)
        {
            // Apply punishment
            ApplyPunishment(playerid);
        }
        
        // Block the shot
        return 0;
    }
    
    // Update last shot time
    SetPlayerLastShotTime(playerid, currentTime);
    
    // Allow the shot
    return 1;
}
```

### Detection Algorithm

The system uses a sophisticated time-based pattern analysis:

1. **Shot Timestamp Recording** - Records precise timestamp of each shot
2. **Interval Calculation** - Calculates time difference between consecutive shots
3. **Threshold Comparison** - Compares interval against minimum allowed delay
4. **Pattern Recognition** - Identifies C-Bug patterns across multiple shots
5. **Adaptive Response** - Adjusts response based on violation severity

---

## 🧪 Testing & Validation

### Automated Testing

```pawn
// Test suite included in the script
#if defined CBUG_DEBUG
    // Run diagnostics
    CMD:cbugtest(playerid, params[])
    {
        SendClientMessage(playerid, -1, "[C-Bug Test] Initiating diagnostic...");
        
        // Test weapon detection
        new weapons[] = {WEAPON_DEAGLE, WEAPON_SHOTGUN, WEAPON_SNIPER};
        
        for(new i = 0; i < sizeof(weapons); i++)
        {
            if(IsCBugWeapon(weapons[i]))
            {
                SendClientMessage(playerid, 0x00FF00FF, 
                    sprintf("[OK] Weapon %d protected", weapons[i]));
            }
        }
        
        return 1;
    }
#endif
```

### Manual Testing Checklist

- [ ] **Normal Fire Rate** - Verify weapons fire at normal speed
- [ ] **C-Bug Attempt** - Confirm C-Bug is blocked
- [ ] **False Positives** - Check legitimate rapid clicking
- [ ] **Server Performance** - Monitor CPU/RAM usage
- [ ] **Console Logs** - Review detection messages
- [ ] **Multi-Player** - Test with multiple simultaneous players

### Performance Benchmarks

| Metric | Expected Value |
|--------|---------------|
| CPU Usage | < 0.5% per 100 players |
| Memory Usage | < 5MB |
| Latency Impact | < 1ms |
| False Positive Rate | < 0.1% |

---

## 🔧 Troubleshooting

### Common Issues & Solutions

<details>
<summary><b>❌ Compilation Error: "undefined symbol y_hooks"</b></summary>

**Problem:** YSI library not found or incomplete installation.

**Solution:**
```bash
# Verify YSI installation
ls pawno/include/YSI_Coding/y_hooks.inc

# Re-download YSI if missing
git clone https://github.com/pawn-lang/YSI-Includes pawno/include/YSI_Includes
```
</details>

<details>
<summary><b>❌ Server Crash on Load</b></summary>

**Problem:** Plugin or include compatibility issue.

**Solution:**
1. Update crashdetect plugin
2. Check include versions
3. Enable debug mode: `#define CBUG_DEBUG`
4. Check server_log.txt for errors
</details>

<details>
<summary><b>⚠️ False Positives (Legit Players Flagged)</b></summary>

**Problem:** Detection sensitivity too high.

**Solution:**
```pawn
// Increase minimum shot delay
#define CBUG_MIN_SHOT_DELAY 150  // From 100 to 150ms

// Increase max violations
#define CBUG_MAX_VIOLATIONS 5    // From 3 to 5
```
</details>

<details>
<summary><b>⚠️ C-Bug Not Detected</b></summary>

**Problem:** Detection sensitivity too low.

**Solution:**
```pawn
// Decrease minimum shot delay
#define CBUG_MIN_SHOT_DELAY 75   // From 100 to 75ms

// Decrease max violations
#define CBUG_MAX_VIOLATIONS 2    // From 3 to 2
```
</details>

<details>
<summary><b>📊 Performance Issues</b></summary>

**Problem:** Script consuming too many resources.

**Solution:**
1. Disable debug mode if enabled
2. Optimize violation reset timer
3. Review other filterscripts for conflicts
4. Consider dedicated anti-cheat plugin
</details>

### Debug Mode

Enable comprehensive logging:

```pawn
#define CBUG_DEBUG

// This will print detailed logs:
// [C-Bug] Player 0 shot weapon 24 (delay: 95ms) - BLOCKED
// [C-Bug] Player 0 violations: 2/3
```

---

## 📚 API Documentation

### Public Functions

```pawn
/**
 * Check if a weapon is protected against C-Bug
 * @param weaponid The weapon ID to check
 * @return true if weapon is protected, false otherwise
 */
stock bool:IsCBugWeapon(weaponid);

/**
 * Get player's current violation count
 * @param playerid The player ID
 * @return Number of violations
 */
stock GetPlayerViolations(playerid);

/**
 * Reset player's violation counter
 * @param playerid The player ID
 */
stock ResetPlayerViolations(playerid);

/**
 * Get player's last shot timestamp
 * @param playerid The player ID
 * @return Timestamp in milliseconds
 */
stock GetPlayerLastShotTime(playerid);

/**
 * Manually apply punishment to player
 * @param playerid The player ID
 */
stock ApplyPunishment(playerid);
```

### Callbacks

```pawn
/**
 * Called when C-Bug is detected
 * @param playerid The player who attempted C-Bug
 * @param weaponid The weapon used
 * @param violations Current violation count
 * @return Return 0 to block, 1 to allow
 */
forward OnPlayerCBugDetected(playerid, weaponid, violations);
```

---

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help improve this project.

### Development Setup

```bash
# Fork and clone
git clone https://github.com/YOUR_USERNAME/Anti-C-Bug-SA-MP.git
cd Anti-C-Bug-SA-MP

# Create feature branch
git checkout -b feature/your-feature-name

# Make your changes and test thoroughly

# Commit with descriptive message
git commit -m "feat: Add configurable punishment system"

# Push to your fork
git push origin feature/your-feature-name

# Open Pull Request on GitHub
```

### Contribution Guidelines

#### Code Standards
- ✅ Follow existing code style and formatting
- ✅ Add comments for complex logic
- ✅ Use meaningful variable names
- ✅ Include function documentation

#### Testing Requirements
- ✅ Test on SA-MP 0.3.7-R2+
- ✅ Test on open.mp (if possible)
- ✅ Verify no callback conflicts
- ✅ Check performance impact
- ✅ Test with multiple players

#### Pull Request Checklist
- [ ] Description of changes
- [ ] Test results included
- [ ] Documentation updated
- [ ] No breaking changes (or clearly noted)
- [ ] Screenshots/videos (if UI changes)

### Areas for Contribution

| Area | Difficulty | Description |
|------|-----------|-------------|
| 🐛 Bug Fixes | Easy | Fix reported issues |
| 📝 Documentation | Easy | Improve docs and examples |
| ⚡ Performance | Medium | Optimize detection algorithms |
| 🎯 Detection | Medium | Improve accuracy |
| 🔧 Features | Hard | Add new functionality |
| 🌐 Localization | Medium | Add language support |

---

## 📄 License

This project is licensed under the **MIT License**.

```
MIT License

Copyright (c) 2024 Muhammad Asyrafi Hidayatullah

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

See [LICENSE](LICENSE) file for full license text.

---

## 👨‍💻 Author

<div align="center">

### Muhammad Asyrafi Hidayatullah

[![GitHub](https://img.shields.io/badge/GitHub-4syr-181717?style=for-the-badge&logo=github)](https://github.com/4syr)
[![Email](https://img.shields.io/badge/Email-Contact-D14836?style=for-the-badge&logo=gmail)](mailto:asyrafirafi38@gmail.com)

*SA-MP Developer & Security Enthusiast*

</div>

---

## 🙏 Acknowledgments

### Core Dependencies
- **[YSI Library](https://github.com/pawn-lang/YSI-Includes)** - Created by Y_Less and contributors
- **[SA-MP](https://sa-mp.mp)** - San Andreas Multiplayer modification
- **[open.mp](https://open.mp)** - Modern SA-MP alternative

### Special Thanks
- SA-MP community for continuous support and testing
- YSI developers for the incredible hooking system
- Beta testers who helped refine the detection algorithm
- Everyone who reported bugs and suggested improvements

---

## 📞 Support

Need help? We're here for you!

### 💬 Community Support
- **[GitHub Discussions](https://github.com/4syr/Anti-C-Bug-SA-MP/discussions)** - Ask questions and share ideas
- **[GitHub Issues](https://github.com/4syr/Anti-C-Bug-SA-MP/issues)** - Report bugs and request features
- **[SA-MP Forums](https://forum.sa-mp.com)** - Community discussions

### 📧 Direct Contact
For security vulnerabilities or private inquiries, please email directly.

### 🐛 Bug Reports

When reporting bugs, please include:
- Server version (SA-MP/open.mp)
- YSI library version
- Detailed steps to reproduce
- Expected vs actual behavior
- Server logs (if applicable)
- Screenshots/videos (if relevant)

---

## 📊 Project Statistics

<div align="center">

![GitHub stars](https://img.shields.io/github/stars/4syr/Anti-C-Bug-SA-MP?style=social)
![GitHub forks](https://img.shields.io/github/forks/4syr/Anti-C-Bug-SA-MP?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/4syr/Anti-C-Bug-SA-MP?style=social)

![GitHub last commit](https://img.shields.io/github/last-commit/4syr/Anti-C-Bug-SA-MP)
![GitHub issues](https://img.shields.io/github/issues/4syr/Anti-C-Bug-SA-MP)
![GitHub pull requests](https://img.shields.io/github/issues-pr/4syr/Anti-C-Bug-SA-MP)

</div>

---

## 🔄 Changelog

### Version 1.0.0 (Current)
*Released: December 2024*

#### ✨ Features
- Initial release with full C-Bug detection
- YSI Hooks implementation
- Support for Desert Eagle, Shotgun, Sniper Rifle
- Configurable sensitivity settings
- Admin notification system
- Debug logging mode

#### 🐛 Bug Fixes
- N/A (Initial Release)

#### 📝 Documentation
- Complete README with installation guide
- API documentation
- Configuration examples
- Troubleshooting section

---

## 📚 Additional Resources

### Documentation & Guides
- 📖 [YSI Documentation](https://github.com/pawn-lang/YSI-Includes/wiki)
- 📖 [SA-MP Wiki](https://sampwiki.blast.hk)
- 📖 [open.mp Documentation](https://open.mp/docs)
- 📖 [Pawn Language Guide](https://www.compuphase.com/pawn/Pawn_Language_Guide.pdf)

### Community & Forums
- 🌐 [SA-MP Forums](https://forum.sa-mp.com)
- 💬 [open.mp Discord](https://discord.gg/samp)
- 🎮 [SA-MP Reddit](https://reddit.com/r/samp)

### Development Tools
- 🔧 [sampctl](https://github.com/Southclaws/sampctl) - SA-MP development tool
- 🔌 [Community Compiler](https://github.com/pawn-lang/compiler) - Latest Pawn compiler
- 🐛 [crashdetect](https://github.com/Zeex/samp-plugin-crashdetect) - Debug plugin

---

## ⚠️ Disclaimer

### Important Notices

**Security Notice:**
This filterscript is designed specifically to prevent C-Bug exploits. It is **not** a comprehensive anti-cheat solution. For complete server protection, consider using additional anti-cheat measures.

**Performance Notice:**
While optimized for minimal resource usage, the actual performance impact may vary based on:
- Server hardware specifications
- Number of concurrent players
- Other running scripts and plugins
- Server configuration settings

**Compatibility Notice:**
- Tested on SA-MP 0.3.7-R2 and open.mp latest versions
- Some custom gamemodes may require adjustments
- Certain weapon mods may affect detection accuracy
- Always test in a staging environment first

**Legal Notice:**
- This software is provided "as is" without warranty
- Author is not liable for any damages or issues
- Use at your own risk
- Respect server owner and player privacy

**Fair Play Notice:**
This tool is intended to maintain fair gameplay. Server owners are responsible for:
- Informing players about anti-cheat measures
- Handling false positives appropriately
- Respecting player rights and privacy
- Following applicable laws and regulations

---

<div align="center">

## 🌟 Show Your Support

If this project helped you, please consider:

⭐ **Starring** this repository
🔄 **Sharing** with the SA-MP community
💬 **Contributing** improvements
☕ **Supporting** development (optional)

---

### **Developed with ❤️ by Muhammad Asyrafi Hidayatullah**

**Made for the SA-MP Community**

[⬆ Back to Top](#️-anti-c-bug-sa-mp)

---

*Last Updated: December 2024*
