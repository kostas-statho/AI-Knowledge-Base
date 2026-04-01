# Style Guide

Use this guide as the implementation reference for recreating the current UI exactly. This project is not a browser-based web app; the primary interface is a Windows Forms desktop UI written in PowerShell 5.1, with one separately styled generated HTML report. Where relevant, this guide notes whether a pattern belongs to the desktop shell, the generated report, or both.

## Overview

### Product purpose

The UI supports a One Identity Manager export workflow. The application is split into several desktop tools:

- `Launchpad_PS5.1 1.ps1`: main launchpad and login gate
- `Launcher_PS5.ps1`: simple ZIP-export launcher
- `Configurator_PS5.ps1`: configuration editor with contextual help sidebar
- `ChangeExplorer_PS51.ps1`: data-heavy explorer with grids, code viewers, and diff dialogs
- `Modules/Common/ExportObjectValidationPDFReport_noTitle.psm1`: generated HTML validation report

### Design philosophy

The visual language is conservative and desktop-oriented:

- Warm neutral background instead of flat gray
- White cards/panels floating on a warm canvas
- Deep purple for branded chrome and section emphasis
- Gold as a thin accent/separator color
- Muted teal for affirmative actions
- `Segoe UI` throughout, with `Consolas` reserved for code/diff views
- Minimal decoration: no rounded corners in WinForms, no shadows in WinForms, almost all structure comes from color blocking, borders, and spacing

### UI architecture

- Primary shell: Windows Forms / `System.Windows.Forms`
- Rendering mode: fixed desktop layouts with `Dock`, `Anchor`, explicit `Size`, and `Padding`
- Responsive behavior: desktop resize behavior only; there are no mobile layouts in the WinForms UI
- HTML/CSS exists only for the exported validation report and uses a separate visual system

## Color Palette

### Core desktop palette

| Token | RGB | Hex | Usage |
|---|---:|---|---|
| `colBackground` | `245, 241, 234` | `#F5F1EA` | App canvas, input backgrounds, secondary button background |
| `colPanel` | `255, 255, 255` | `#FFFFFF` | Cards, sidebars, content panels, data grid base |
| `colPurple` | `112, 48, 105` | `#703069` | Headers, titles, primary brand color, outlined button text/border |
| `colPurpleHover` | `138, 68, 130` | `#8A4482` | Hover state for purple primary buttons |
| `colPurpleLight` | `245, 238, 244` | `#F5EEF4` | Light lavender grouping row in Change Explorer |
| `colGold` | `214, 182, 105` | `#D6B669` | Accent line, help toggle button, sidebar divider |
| `colTeal` | `120, 172, 156` | `#78AC9C` | Primary action buttons, grid headers |
| `colTealHover` | `140, 192, 176` | `#8CC0B0` | Hover state for teal buttons |
| `colTextDark` | `45, 35, 50` | `#2D2332` | Main body text |
| `colTextMuted` | `130, 120, 125` | `#82787D` | Captions, hints, disabled copy, metadata |
| `colBorder` | `210, 200, 195` | `#D2C8C3` | Dividers, grid lines, disabled buttons |
| `colWhite` | `255, 255, 255` | `#FFFFFF` | Text on dark fills |

### State colors

| Token | RGB | Hex | Usage |
|---|---:|---|---|
| `colSuccess` | `60, 140, 80` | `#3C8C50` | Success status text |
| `colError` | `180, 50, 50` | `#B43232` | Error / invalid state text |
| `colPending` | `200, 140, 40` | `#C88C28` | Pending / warning state text |
| warning panel bg | `255, 244, 214` | `#FFF4D6` | Launchpad runtime warning banner |
| close hover bg | `235, 231, 224` | `#EBE7E0` | Hover state for outlined close button |

### Code and diff surface colors

| Surface | Hex | Usage |
|---|---|---|
| line-number gutter bg | `#EBE8E4` | Code/diff line number columns |
| code viewer bg | `#FAF8F5` | Code and diff text area |
| diff highlight | `#FFFFC8` | Generic changed-line highlight |
| diff added | `#DCFFDC` | Added lines |
| diff removed | `#FFDCDC` | Removed lines |
| grouped row bg | `#F0EBF5` | Section separator rows in group/object grids |

### HTML report palette

The generated report does not reuse the desktop purple/gold/teal system. It uses a softer neutral-blue report theme:

| Role | Hex |
|---|---|
| page bg | `#F7F7FB` |
| text | `#1F2430` |
| card border | `#E6E6EF` |
| card shadow | `rgba(0,0,0,0.08)` |
| meta tile bg | `#FAFAFE` |
| meta tile border | `#ECECF6` |
| table header bg | `#F1F3FF` |
| table header border | `#DFE3FF` |
| zebra row | `#FCFCFF` |
| invalid row | `#FFF5F5` |
| row hover | `#F0F4FF` |
| valid pill bg | `#E6F7EC` |
| valid pill fg | `#0B6B2B` |
| invalid pill bg | `#FFE5E5` |
| invalid pill fg | `#8A1F1F` |

### Swatch preview

- `#703069` purple
- `#D6B669` gold
- `#78AC9C` teal
- `#F5F1EA` warm background
- `#2D2332` dark text
- `#82787D` muted text

## Typography

### Desktop font stack

- Primary UI font: `Segoe UI`
- Semibold variant: `Segoe UI Semibold`
- Monospace: `Consolas`

### Type scale

| Style | Font | Size | Weight/style | Typical usage |
|---|---|---:|---|---|
| `fontTitle` | `Segoe UI` | `16px` | Bold | Window titles in purple headers |
| `fontSubhead` | `Segoe UI Semibold` | `10px` | Semibold | Section headers, card titles |
| `fontLabel` | `Segoe UI` | `9px` | Regular | Field labels, body copy |
| `fontInput` | `Segoe UI` | `9.5px` | Regular | Text inputs |
| `fontButton` | `Segoe UI Semibold` | `10px` | Semibold | Main buttons |
| `fontSmall` | `Segoe UI` | `8px` | Regular | Browse and show/hide utility buttons |
| `fontCaption` | `Segoe UI` | `8px` | Italic | Hints, status copy, module path, disabled reasons |
| `fontGrid` | `Segoe UI` | `9px` | Regular | Data grid rows |
| `fontGridHead` | `Segoe UI Semibold` | `9px` | Semibold | Data grid column headers |
| dialog title | `Segoe UI` | `13px` | Bold | Explorer modal headers |
| help head | `Segoe UI Semibold` | `11px` | Semibold | Configurator help sidebar title |
| help title | `Segoe UI Semibold` | `9px` | Semibold | Help field names |
| help body | `Segoe UI` | `8.5px` | Regular | Help descriptions |
| code font | `Consolas` | `10px` | Regular | Single code viewer |
| diff code font | `Consolas` | `9.5px` | Regular | Side-by-side diff viewer |

### Typography examples

```css
/* Header title */
font-family: "Segoe UI";
font-size: 16px;
font-weight: 700;
color: #FFFFFF;

/* Section title */
font-family: "Segoe UI Semibold";
font-size: 10px;
font-weight: 600;
color: #703069;

/* Body / label */
font-family: "Segoe UI";
font-size: 9px;
font-weight: 400;
color: #2D2332;

/* Caption */
font-family: "Segoe UI";
font-size: 8px;
font-style: italic;
color: #82787D;

/* Code */
font-family: Consolas, monospace;
font-size: 10px;
color: #2D2332;
```

### Letter spacing and line height

- The WinForms UI does not define custom letter spacing.
- Line height is mostly implicit through control height and default font metrics.
- The HTML report adds `letter-spacing: 0.5px` to table headers and metadata labels.

## Spacing & Layout

### Base spacing rhythm

There is no single declared token scale, but the UI consistently uses 4px-based spacing with frequent 12, 16, 18, 20, 24, and 26px increments.

Common values:

- `3px`: accent line under top header
- `4px`: grid cell padding, label offsets, line-number gutter padding
- `8px`: small vertical spacing, hint padding, report gaps
- `10px`: row top padding, button/input utility spacing
- `12px`: card internal padding in grid-heavy views
- `16px`: content inset, warning copy inset, report padding
- `18px`: title top offset, main panel padding
- `20px`: left/right edge inset in cards and dialogs
- `24px`: main outer padding, header title inset
- `26px`: login dialog outer horizontal padding
- `40px`: standard primary button height in tool cards
- `44px`: primary CTA height in launcher/login/configurator
- `70px`: standard top header and bottom action bar height

### Window sizes

| Surface | Default size | Minimum size | Notes |
|---|---|---|---|
| Launcher | `560x480` | `460x480` | Simple single-card form |
| Configurator | `760x660`, maximized on load | `600x500` | Main form with optional right sidebar |
| Launchpad main | `860x560` | `720x520` | Tool cards |
| Launchpad login | `760x520` | fixed dialog | Non-resizable |
| Change Explorer | `1200x700` | `900x500` | Split-view data explorer |
| Code viewer | `1000x700` | `500x300` | Modal |
| Diff viewer | `1400x800` | `800x400` | Modal |
| Detail grids | `1200x400` to `1200x700` | `700x300` to `750x400` | Modal variants |

### Layout patterns

#### Top chrome

Every major desktop window uses:

1. Purple header panel, `70px` tall
2. White title text at roughly `24px` left inset and `18px` top inset
3. Gold accent strip directly below header, `3px` tall

#### Card layout

- Background canvas: `#F5F1EA`
- Primary content: white rectangular panel
- Borders: typically `FixedSingle` when the card needs definition
- No corner radius
- No shadows

#### Split layouts

- Change Explorer uses a `SplitContainer` with a border-colored divider
- Panels use white cards inside the split
- Minimum pane width is promoted from `50` to `300` in the main explorer

#### Sidebar layout

- Configurator help panel docks right at a fixed `280px` width
- Left border is a `2px` gold rule
- Internal content padding is `16px`
- Sidebar is hidden by default and toggled from the header button

#### Grid layout

- Launchpad login uses a `TableLayoutPanel`
- 2 columns: `210px` fixed label column + remaining width flexible input column
- Table gets `10px` top padding

### Responsive behavior

Desktop resizing is handled through `Anchor`, `Dock`, and a few resize callbacks:

- Buttons are repositioned on panel resize in login/action bars
- Tool-card descriptions and disabled-reason labels expand/shrink with card width
- Warning banner text width recalculates on resize
- Configurator main card stretches horizontally but remains vertically scrollable

There are no mobile breakpoints, no hamburger menu, and no phone-specific layouts in the WinForms UI.

The HTML report is the only surface with responsive web behavior:

- metadata uses `grid-template-columns: repeat(auto-fit, minmax(200px, 1fr))`
- toolbar wraps on small widths
- table container scrolls horizontally and vertically

## Components

### App shell header

#### Structure

```text
Form
|- HeaderPanel (purple, 70px)
|  `- Title Label
`- AccentLine (gold, 3px)
```

#### Visual rules

- Header background: `#703069`
- Title: `Segoe UI`, `16px`, bold, white
- Accent line: `#D6B669`
- Title position: typically `24px` to `26px` from left, `18px` to `20px` from top

### Primary button

Used for `Run Export`, `Connect`, `Run`, and other confirm actions.

#### Visual rules

- Background: `#703069` in Launcher/Configurator main CTA, `#78AC9C` in Launchpad cards/login and grid headers
- Text: white
- Font: `Segoe UI Semibold`, `10px`
- Height: `40px` or `44px`
- Border: none
- Flat style: `Flat`
- Cursor: hand

#### States

- Purple primary hover: `#8A4482`
- Teal primary hover: `#8CC0B0`
- Disabled action button: background `#D2C8C3`, text `#82787D`, cursor default

#### WinForms example

```powershell
$btn.FlatStyle = 'Flat'
$btn.BackColor = $colTeal
$btn.ForeColor = $colWhite
$btn.FlatAppearance.BorderSize = 0
$btn.Cursor = [System.Windows.Forms.Cursors]::Hand
```

### Secondary / outlined button

Used for `Cancel`, `Close`, and password show/hide controls.

#### Visual rules

- Background: `#F5F1EA`
- Text and border: `#703069`
- Border width: `1px`
- Flat style

#### States

- Close button hover: `#EBE7E0`
- Password toggle swaps only text content (`Show` / `Hide`), not color

### Gold utility button

Used for the Configurator help toggle.

- Background: `#D6B669`
- Text: dark body color `#2D2332`
- Size: `90x34`
- On open state: switches to white fill with purple text and changes label from `?  Help` to `X  Close`

### Text input

Used throughout login and config forms.

#### Visual rules

- Background: `#F5F1EA`
- Font: `Segoe UI`, `9.5px`
- Border style: `FixedSingle`
- Height: roughly `24px`
- Password fields use `UseSystemPasswordChar = true`

#### Layout pattern

Often paired with a right-aligned utility button in a single 30-32px-high container.

```text
+-----------------------------------------------------------+
| [ text input................................ ] [Browse...] |
+-----------------------------------------------------------+
```

### Browse row

Shared composite control in Launcher and Configurator.

#### Structure

```powershell
Panel (transparent)
|- TextBox
`- Button
```

#### Dimensions

- Total row height: `30px` to `32px`
- Utility button width: `90px` to `96px`
- Gap between text box and button: `10px`

### Checkbox

Used for boolean options and integrated security.

- Font: `Segoe UI`, `9px`
- Text color: `#2D2332`
- Background: either transparent or white panel background
- Height: `24px`

### Section label

Used for `PATHS`, `OPTIONS`, `ZIP FILE`, `LIBRARIES`, etc.

- Font: `Segoe UI Semibold`, `10px`
- Color: `#703069`
- Generally uppercase in content, though casing is hard-coded per label text

### Caption / hint text

Used for optional markers, status lines, module path, disabled reasons.

- Font: `Segoe UI`, `8px`, italic
- Color: `#82787D`

### Tool card

Used on the main Launchpad.

#### Structure

```text
+-------------------------------------------------------------+
| Tool title                                      [ Run ]     |
| Description text, up to two lines                           |
| Optional disabled reason                                    |
+-------------------------------------------------------------+
```

#### Visual rules

- Background: white
- Border: `FixedSingle`
- Height: `120px`
- Internal content:
  - title at `18,18`
  - description at `18,46`
  - action button at right, `110x40`
  - disabled reason at `18,92` when present

### Warning banner

Used in Launchpad when config/runtime initialization fails.

- Background: `#FFF4D6`
- Border: `FixedSingle`
- Title color: `#2D2332`
- Body color: `#2D2332`
- Title inset: `16,12`
- Body inset: `16,36`
- Height: `86px`

### Configurator help sidebar

#### Structure

```text
Right Docked Panel (280px)
|- 2px gold border
`- Scrollable white content
   |- "Field Reference" title
   |- 2px gold accent rule
   `- repeated section blocks
```

#### Typography

- Sidebar title: `Segoe UI Semibold`, `11px`, purple
- Section names: `Segoe UI Semibold`, `10px`, purple
- Field names: `Segoe UI Semibold`, `9px`, dark text
- Descriptions: `Segoe UI`, `8.5px`, muted text

### Data grid

The Change Explorer’s grid styling is the most explicit reusable component definition in the project.

#### Base rules

- Background: white
- Grid line color: `#D2C8C3`
- Border style: none
- Cell border style: `SingleHorizontal`
- Full-row selection
- Read-only
- No row headers
- Auto-size columns to fill
- Row height: `30px`
- Alternating row background: `#F5F1EA`

#### Header rules

- Background: `#78AC9C`
- Text: white
- Font: `Segoe UI Semibold`, `9px`
- Alignment: left
- Padding: `4px`
- Height: `34px`

#### Selection

- Selected row background: `#F5F1EA`
- Selected row text: `#2D2332`

#### Status coloring

Certain cells are recolored semantically:

- error: `#B43232`
- success: `#3C8C50`
- pending: `#C88C28`
- special separator/group rows: lavender `#F0EBF5`, semibold purple text

### Code viewer

Used in Change Explorer modal code views.

#### Structure

```text
Modal Form
|- Purple header + gold accent
`- White content panel
   |- line-number RichTextBox
   |- 1px border gutter
   `- code RichTextBox
```

#### Visual rules

- Line-number gutter background: `#EBE8E4`
- Line-number text: `#82787D`
- Code background: `#FAF8F5`
- Code text: `#2D2332`
- Font: `Consolas 10px`

### Diff viewer

The diff modal uses two side-by-side code panes with color-coded highlights.

- Modal chrome matches other explorer dialogs
- Left and right panes each use gutter + border + code area
- Font: `Consolas 9.5px`
- Changed line highlight: `#FFFFC8`
- Added line: `#DCFFDC`
- Removed line: `#FFDCDC`

### Message boxes and legacy warning dialog

Most system alerts use standard `MessageBox` styling from Windows Forms and are not custom themed.

One exception is the stale-object dialog in `XDateCheck.psm1`, which uses:

- default Windows dialog styling
- plain `Segoe UI 9px`
- selectable borderless text rows
- blue `Export` button (`SteelBlue`, `#4682B4`)
- red `Abort` button (`Firebrick`, `#B22222`)

This dialog does not follow the purple/gold/teal house style and should be treated as a legacy exception.

## Effects & Interactions

### Borders and radii

- WinForms UI uses rectangular controls only
- No border radius in desktop shell
- Cards often use `FixedSingle`
- Divider lines are 1px panels in `#D2C8C3`
- Accent rules are 2px or 3px in `#D6B669`

### Shadows

- No desktop shadows
- HTML report uses `box-shadow: 0 4px 12px rgba(0,0,0,0.08)` on the main report card only

### Hover behavior

- Teal buttons lighten to `#8CC0B0`
- Purple primary buttons darken/lighten to `#8A4482`
- Outlined close button shifts to `#EBE7E0`
- HTML report rows highlight to `#F0F4FF`
- HTML report scrollbar thumb darkens from `#C1C1C1` to `#A8A8A8`

### Focus / active

- No custom focus ring styling is defined in the WinForms UI
- Interaction depends on standard Windows control focus behavior
- Login forms wire `AcceptButton` and `CancelButton` for Enter/Escape submission

### Loading / busy states

- Login flow sets `UseWaitCursor = true`
- Buttons are disabled during connection attempts
- Status label changes to `Connecting...`
- No spinner or skeleton loading pattern is implemented

### Scrolling

- Configurator main content and sidebar are scrollable panels
- HTML report table has both vertical and horizontal scroll
- Change Explorer grids fill available area and rely on native grid scrolling

## Icons & Images

### Desktop shell

- No custom image system is used
- No icon library is present
- `XDateCheck.psm1` uses `SystemIcons.Warning`
- Primary branding is color- and typography-based rather than icon-based

### HTML report

- No icons or images
- Status is represented by text pills only

## Responsive Design

### Desktop application

This project does not implement responsive web breakpoints. Reproduction should preserve fixed desktop composition and resize behavior:

- preserve `MinimumSize` limits
- preserve header height at `70px`
- preserve button heights at `40px` or `44px`
- preserve sidebar width at `280px`
- preserve form/card edge insets of `24px` to `26px`

### HTML report

The report adapts through CSS rather than breakpoints:

- metadata grid auto-fits to available width
- toolbar wraps
- sticky table headers remain pinned during scroll
- print mode removes page background and card shadow

## CSS Framework / Custom Code

### Desktop shell

- Framework: none
- Technology: PowerShell 5.1 with `System.Windows.Forms` and `System.Drawing`
- No Bootstrap, Tailwind, SCSS, CSS variables, or utility framework

### HTML report

- Framework: none
- Styling is inline in a generated `<style>` block
- No external stylesheet

### Key custom implementation patterns

- Shared visual tokens are hard-coded as PowerShell color/font variables in each script
- Reusable component factories exist for labels, browse rows, separators, and checkboxes
- The grid style is centralized in `Set-GridStyle()` inside `ChangeExplorer_PS51.ps1`

## Reference Snippets

### Desktop token definition pattern

```powershell
$colBackground = [System.Drawing.Color]::FromArgb(245, 241, 234)
$colPurple     = [System.Drawing.Color]::FromArgb(112, 48, 105)
$colGold       = [System.Drawing.Color]::FromArgb(214, 182, 105)
$fontTitle     = New-Object System.Drawing.Font('Segoe UI', 16, [System.Drawing.FontStyle]::Bold)
```

### Grid styling pattern

```powershell
$grid.ColumnHeadersDefaultCellStyle.BackColor  = $colTeal
$grid.ColumnHeadersDefaultCellStyle.ForeColor  = $colWhite
$grid.DefaultCellStyle.SelectionBackColor      = $colBackground
$grid.AlternatingRowsDefaultCellStyle.BackColor = $colBackground
```

### HTML report card

```html
<div class="card">
  <h1>Transport Export Report</h1>
  <div class="meta">...</div>
  <div class="toolbar">...</div>
  <div class="table-wrap">
    <table>...</table>
  </div>
</div>
```

```css
.card {
  background: #fff;
  border: 1px solid #e6e6ef;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  padding: 24px;
}
```

## Validation Notes

### What was verified

- Shared desktop palette and typography were cross-checked across `Launchpad`, `Launcher`, `Configurator`, and `ChangeExplorer`
- Reusable controls were verified from source-level helper functions rather than inferred visually
- Grid, code viewer, diff viewer, and warning states were checked directly against implementation
- HTML report styling was extracted from the generated CSS block

### Ambiguities and exceptions

- No browser-based UI exists in this repository, so there are no browser DevTools-derived computed styles for the main application
- No mobile design exists for the desktop shell
- Standard `MessageBox` dialogs mostly use OS defaults and should not be treated as branded UI
- `XDateCheck.psm1` uses a different legacy palette and should be replicated separately only if that dialog matters

### Recommended fidelity targets

If another agent rebuilds the UI, the most important fidelity checks are:

1. Purple header + gold accent strip on every major window
2. Warm `#F5F1EA` canvas against white content cards
3. Teal and purple button behavior, including hover states
4. Segoe UI scale, especially `16px` title / `10px` semibold section hierarchy
5. Change Explorer data-grid header styling, alternating rows, and status colors
6. Code/diff surfaces using `Consolas` with warm neutral gutters and pale code background
