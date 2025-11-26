# Windows Icon Update Guide

## 📝 What Changed

The Windows app icon has been updated to use the Orbit Digilib logo from `assets/logo/orbit-digilib-logo-o-foreground.png`.

## 🔧 How to Rebuild with New Icon

### Option 1: Quick Rebuild (Recommended)
Use the dedicated icon rebuild script:
```bash
rebuild_windows_icon.bat [debug|release]
```

Examples:
```bash
# Release build
rebuild_windows_icon.bat release

# Debug build  
rebuild_windows_icon.bat debug
```

### Option 2: Full Build with Installer
```bash
build_windows.bat release
```

The improved `build_windows.bat` now automatically:
- Removes cached build files
- Forces recompilation of resource files (Runner.rc)
- Properly embeds the new icon

## ⚠️ Why Icon Didn't Update Before

The Windows executable embeds the icon at compile time through:
1. `windows/runner/Runner.rc` - Resource script that references the icon
2. `windows/runner/resources/app_icon.ico` - The actual icon file

If the build cache wasn't cleared, Visual Studio would use old compiled object files instead of recompiling with the new icon.

## 🖼️ Icon Location

- **File**: `windows/runner/resources/app_icon.ico`
- **Source**: `assets/logo/orbit-digilib-logo-o-foreground.png`
- **Sizes**: 16×16, 32×32, 48×48, 64×64, 96×96, 128×128, 256×256 pixels

## 🔄 To Change Icon Again

1. Replace `windows/runner/resources/app_icon.ico` with a new `.ico` file, or
2. Use the Python script to convert PNG to ICO:

```python
from PIL import Image

input_logo = "path/to/your/logo.png"
output_icon = "windows/runner/resources/app_icon.ico"

img = Image.open(input_logo)
if img.mode == 'RGBA':
    background = Image.new('RGB', img.size, (255, 255, 255))
    background.paste(img, mask=img.split()[3])
    img = background

sizes = [(256, 256), (128, 128), (96, 96), (64, 64), (48, 48), (32, 32), (16, 16)]
img_resized = [img.resize((size, size), Image.Resampling.LANCZOS) for size in sizes]
img_resized[0].save(output_icon, format='ICO', sizes=sizes)
```

3. Run rebuild: `rebuild_windows_icon.bat release`

## 📍 Where Icon Appears

- ✓ Application window title bar
- ✓ Windows task bar
- ✓ Installer dialog (Inno Setup)
- ✓ Desktop shortcut
- ✓ Start menu
- ✓ File explorer

## 🆘 Troubleshooting

If icon still doesn't update:

1. **Full system clean**:
   ```bash
   flutter clean
   ```

2. **Delete build directories**:
   ```bash
   rmdir /s /q build
   rmdir /s /q windows\runner\Release
   rmdir /s /q windows\runner\Debug
   ```

3. **Rebuild**:
   ```bash
   rebuild_windows_icon.bat release
   ```

4. **Verify icon file**:
   ```bash
   # Check the ICO file exists
   dir windows\runner\resources\app_icon.ico
   ```
