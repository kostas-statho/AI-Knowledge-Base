---
description: Capture a screenshot of the GoalSetter app (auto-launches if not running), read the image, and report visual layout issues.
---

Take a screenshot of the GoalSetter app window and analyze it for visual issues. Steps:

1. Run the screenshot script from the project root:
   ```
   powershell -ExecutionPolicy Bypass -File scripts/Take-Screenshot.ps1
   ```
   The script will auto-launch the app if it is not already running, wait for the window to appear, capture it, and print the saved path.

2. Read the printed output path and use the Read tool to view the captured image.

3. For each visible tab, switch to it by sending a tab-click (Tab key) if needed, re-run the script, and read the new screenshot.

4. List every visual issue found (overlapping controls, clipped text, truncated labels, misaligned elements, scroll panels hiding buttons, etc.) with the tab name and control description.

5. Fix the issues by editing the appropriate `src/ui/Tab*.ps1` file.
