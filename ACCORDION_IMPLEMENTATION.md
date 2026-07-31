# Accordion Component Implementation

This implementation converts the React MUI Accordion component to Flutter/Dart with full theme integration and both Simple and Controlled variants.

## Files Created/Modified

### 1. Enhanced CustomAccordion Component
**File**: `lib/components/accordion/custom_accordion.dart`

**Features**:
- Implements MUI accordion theme logic with shadows, colors, and styling
- Supports both Simple (multiple expansion) and Controlled (single expansion) modes
- Follows Material-UI design patterns
- Full theme integration with the existing theme system
- Disabled state support
- Custom icons, subtitles, and content support

**Key Properties**:
- `allowMultipleExpanded`: Controls whether multiple panels can be expanded (Simple vs Controlled)
- `expandedPanelId`: For controlled accordion, specifies which panel is expanded
- `onExpansionChanged`: Callback for expansion state changes
- Theme integration with shadows, colors, and typography

### 2. Block Component
**File**: `lib/components/block/block.dart`

**Purpose**: Equivalent to React MUI Block component for displaying component variants and examples.

**Features**:
- Paper-style container with borders and background
- Optional title header
- Configurable padding and minimum height
- Theme-aware styling

### 3. Accordion Page
**File**: `lib/pages/components/accordion_page.dart`

**Purpose**: Main demonstration page showing both accordion variants, equivalent to React `accordion.tsx`.

**Features**:
- **Simple Accordion**: Multiple panels can be expanded simultaneously
- **Controlled Accordion**: Only one panel can be expanded at a time
- Breadcrumb navigation
- MUI documentation link
- Theme-aware header section
- Disabled accordion example

### 4. Accordion Example
**File**: `lib/pages/components/accordion_example.dart`

**Purpose**: Practical examples showing real-world usage of both accordion types.

**Features**:
- Settings panels example (Simple accordion)
- Account management example (Controlled accordion)
- Rich content with icons, forms, and interactive elements
- Usage documentation

## Theme Logic Implementation

The accordion implements the MUI theme logic from `Accordion-theme.ts`:

### Root Styling
```dart
// Transparent background by default
backgroundColor: Colors.transparent

// Expanded state with shadow and border radius
decoration: BoxDecoration(
  color: isExpanded ? palette.background.paper : Colors.transparent,
  borderRadius: isExpanded ? BorderRadius.circular(borderRadius) : null,
  boxShadow: isExpanded ? shadows[8] : null, // Equivalent to theme.customShadows.z8
)
```

### Summary Styling
```dart
// Custom padding (equivalent to paddingLeft: theme.spacing(2), paddingRight: theme.spacing(1))
tilePadding: EdgeInsets.only(
  left: useTheme.theme.textTheme.bodyMedium!.fontSize! * 2,
  right: useTheme.theme.textTheme.bodyMedium!.fontSize! * 1,
)

// Icon and text colors for expanded/collapsed states
iconColor: isExpanded ? palette.common.primary.main : palette.text.secondary,
textColor: isExpanded ? palette.common.primary.main : palette.text.primary,
```

### Disabled State
```dart
// Disabled accordions maintain transparency and proper color inheritance
opacity: item.id == 'panel4' ? 0.6 : 1.0,
```

## Usage Examples

### Simple Accordion (Multiple Expansion)
```dart
CustomAccordion(
  allowMultipleExpanded: true,
  items: [
    AccordionItem(
      id: 'panel1',
      title: 'Settings',
      subtitle: 'Configure your preferences',
      icon: Icons.settings,
      content: Text('Settings content here'),
    ),
    // ... more items
  ],
)
```

### Controlled Accordion (Single Expansion)
```dart
String? expandedPanel;

CustomAccordion(
  allowMultipleExpanded: false,
  expandedPanelId: expandedPanel,
  onExpansionChanged: (panelId, isExpanded) {
    setState(() {
      expandedPanel = isExpanded ? panelId : null;
    });
  },
  items: [
    // ... accordion items
  ],
)
```

### Block Usage
```dart
Block(
  title: 'Example Block',
  child: YourComponentHere(),
)
```

## Key Differences from React Implementation

1. **State Management**: Flutter uses StatefulWidget with setState instead of React hooks
2. **Theme Access**: Uses custom `UseTheme` class instead of MUI theme hooks
3. **Styling**: Uses Flutter's DecoratedBox and BoxDecoration instead of CSS-in-JS
4. **Event Handling**: Uses callback functions instead of React event handlers
5. **Component Structure**: Uses Widget tree instead of JSX

## Integration with Existing Theme System

The implementation fully integrates with the existing theme system:
- Uses `UseTheme` for theme access
- Respects light/dark mode settings
- Uses custom palette colors and typography
- Implements shadow system equivalent to MUI's z-index shadows
- Follows existing component patterns and naming conventions

## Benefits

1. **Consistent Design**: Matches MUI accordion behavior and appearance
2. **Theme Integration**: Works seamlessly with the existing theme system
3. **Accessibility**: Maintains Flutter's built-in accessibility features
4. **Performance**: Optimized for Flutter's widget rendering system
5. **Flexibility**: Supports both simple and controlled usage patterns
6. **Extensibility**: Easy to add new features and customizations
