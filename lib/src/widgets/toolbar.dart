import 'package:flutter/material.dart';

import '../models/themes/quill_custom_button.dart';
import '../models/themes/quill_dialog_theme.dart';
import '../models/themes/quill_icon_theme.dart';
import 'controller.dart';
import 'embeds.dart';
import 'toolbar/enum.dart';

export 'toolbar/clear_format_button.dart';
export 'toolbar/color_button.dart';
export 'toolbar/history_button.dart';
export 'toolbar/indent_button.dart';
export 'toolbar/link_style_button.dart';
export 'toolbar/link_style_button2.dart';
export 'toolbar/quill_font_family_button.dart';
export 'toolbar/quill_font_size_button.dart';
export 'toolbar/quill_icon_button.dart';
export 'toolbar/search_button.dart';
export 'toolbar/select_alignment_button.dart';
export 'toolbar/select_header_style_button.dart';
export 'toolbar/toggle_check_list_button.dart';
export 'toolbar/toggle_style_button.dart';

/// The default size of the icon of a button.
const double kDefaultIconSize = 14;

/// The factor of how much larger the button is in relation to the icon.
const double kIconButtonFactor = 1.77;

/// The horizontal margin between the contents of each toolbar section.
const double kToolbarSectionSpacing = 4;

class QuillToolbar extends StatelessWidget implements PreferredSizeWidget {
  const QuillToolbar({
    required this.toolbarWidget,
    this.axis = Axis.horizontal,
    this.toolbarSize = kDefaultIconSize * 2,
    this.toolbarSectionSpacing = kToolbarSectionSpacing,
    this.toolbarIconAlignment = WrapAlignment.center,
    this.toolbarIconCrossAlignment = WrapCrossAlignment.center,
    this.multiRowsDisplay = true,
    this.color,
    this.customButtons = const [],
    this.locale,
    VoidCallback? afterButtonPressed,
    this.sectionDividerColor,
    this.sectionDividerSpace,
    Key? key,
  }) : super(key: key);

  factory QuillToolbar.basic({
    required QuillController controller,
    required Widget toolbarWidget,
    Axis axis = Axis.horizontal,
    double toolbarIconSize = kDefaultIconSize,
    double toolbarSectionSpacing = kToolbarSectionSpacing,
    WrapAlignment toolbarIconAlignment = WrapAlignment.center,
    WrapCrossAlignment toolbarIconCrossAlignment = WrapCrossAlignment.center,
    bool showDividers = false,
    bool showFontFamily = false,
    bool showFontSize = false,
    bool showSmallButton = false,
    bool showUnderLineButton = false,
    bool showStrikeThrough = false,
    bool showInlineCode = false,
    bool showColorButton = false,
    bool showBackgroundColorButton = false,
    bool showClearFormat = false,
    bool showAlignmentButtons = false,
    bool showLeftAlignment = false,
    bool showCenterAlignment = false,
    bool showRightAlignment = false,
    bool showJustifyAlignment = false,
    bool showHeaderStyle = false,
    bool showListCheck = false,
    bool showCodeBlock = false,
    bool showQuote = false,
    bool showIndent = false,
    bool showLink = false,
    bool showUndo = false,
    bool showRedo = false,
    bool multiRowsDisplay = false,
    bool showDirection = false,
    bool showSearchButton = false,
    List<QuillCustomButton> customButtons = const [],

    ///Map of font sizes in string
    Map<String, String>? fontSizeValues,

    ///Map of font families in string
    Map<String, String>? fontFamilyValues,

    /// Toolbar items to display for controls of embed blocks
    List<EmbedButtonBuilder>? embedButtons,

    ///The theme to use for the icons in the toolbar, uses type [QuillIconTheme]
    QuillIconTheme? iconTheme,

    ///The theme to use for the theming of the [LinkDialog()],
    ///shown when embedding an image, for example
    QuillDialogTheme? dialogTheme,

    /// Callback to be called after any button on the toolbar is pressed.
    /// Is called after whatever logic the button performs has run.
    VoidCallback? afterButtonPressed,

    ///Map of tooltips for toolbar  buttons
    ///
    ///The example is:
    ///```dart
    /// tooltips = <ToolbarButtons, String>{
    ///   ToolbarButtons.undo: 'Undo',
    ///   ToolbarButtons.redo: 'Redo',
    /// }
    ///
    ///```
    ///
    /// To disable tooltips just pass empty map as well.
    Map<ToolbarButtons, String>? tooltips,

    /// The locale to use for the editor toolbar, defaults to system locale
    /// More at https://github.com/singerdmx/flutter-quill#translation
    Locale? locale,

    /// The color of the toolbar
    Color? color,

    /// The color of the toolbar section divider
    Color? sectionDividerColor,

    /// The space occupied by toolbar divider
    double? sectionDividerSpace,
    Key? key,
  }) {
    return QuillToolbar(
      key: key,
      axis: axis,
      color: color,
      toolbarSize: toolbarIconSize * 2,
      toolbarSectionSpacing: toolbarSectionSpacing,
      toolbarIconAlignment: toolbarIconAlignment,
      toolbarIconCrossAlignment: toolbarIconCrossAlignment,
      multiRowsDisplay: multiRowsDisplay,
      customButtons: customButtons,
      locale: locale,
      afterButtonPressed: afterButtonPressed,
      toolbarWidget: toolbarWidget,
    );
  }

  final Widget toolbarWidget;
  final Axis axis;
  final double toolbarSize;
  final double toolbarSectionSpacing;
  final WrapAlignment toolbarIconAlignment;
  final WrapCrossAlignment toolbarIconCrossAlignment;
  final bool multiRowsDisplay;

  /// The color of the toolbar.
  ///
  /// Defaults to [ThemeData.canvasColor] of the current [Theme] if no color
  /// is given.
  final Color? color;

  /// The locale to use for the editor toolbar, defaults to system locale
  /// More https://github.com/singerdmx/flutter-quill#translation
  final Locale? locale;

  /// List of custom buttons
  final List<QuillCustomButton> customButtons;

  /// The color to use when painting the toolbar section divider.
  ///
  /// If this is null, then the [DividerThemeData.color] is used. If that is
  /// also null, then [ThemeData.dividerColor] is used.
  final Color? sectionDividerColor;

  /// The space occupied by toolbar section divider.
  final double? sectionDividerSpace;

  @override
  Size get preferredSize => axis == Axis.horizontal
      ? Size.fromHeight(toolbarSize)
      : Size.fromWidth(toolbarSize);

  @override
  Widget build(BuildContext context) {
    return toolbarWidget;
  }
}

/// The divider which is used for separation of buttons in the toolbar.
///
/// It can be used outside of this package, for example when user does not use
/// [QuillToolbar.basic] and compose toolbat's children on its own.
class QuillDivider extends StatelessWidget {
  const QuillDivider(
    this.axis, {
    Key? key,
    this.color,
    this.space,
  }) : super(key: key);

  /// Provides a horizonal divider for vertical toolbar.
  const QuillDivider.horizontal({Color? color, double? space})
      : this(Axis.horizontal, color: color, space: space);

  /// Provides a horizonal divider for horizontal toolbar.
  const QuillDivider.vertical({Color? color, double? space})
      : this(Axis.vertical, color: color, space: space);

  /// The axis along which the toolbar is.
  final Axis axis;

  /// The color to use when painting this divider's line.
  final Color? color;

  /// The divider's space (width or height) depending of [axis].
  final double? space;

  @override
  Widget build(BuildContext context) {
    // Vertical toolbar requires horizontal divider, and vice versa
    return axis == Axis.vertical
        ? Divider(
            height: space,
            color: color,
            indent: 12,
            endIndent: 12,
          )
        : VerticalDivider(
            width: space,
            color: color,
            indent: 12,
            endIndent: 12,
          );
  }
}
