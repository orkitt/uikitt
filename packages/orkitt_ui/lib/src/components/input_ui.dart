// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../ui/extension/widget_ext.dart';

/// Extension methods for [TextStyle] to provide fallback values.
extension TextStyleExtension on TextStyle {
  /// Returns a new [TextStyle] with null properties replaced by fallback values.
  ///
  /// For each nullable property, if the current value is null and a fallback
  /// value is provided, the fallback value is used. Otherwise, the current
  /// value (whether null or not) is retained.
  TextStyle fallback({
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    TextOverflow? overflow,
  }) {
    /// Helper function to apply fallback logic for nullable properties.
    T? fallback<T>(T? currentValue, T? newValue) {
      return currentValue == null && newValue != null ? newValue : currentValue;
    }

    return TextStyle(
      color: fallback(this.color, color),
      backgroundColor: fallback(this.backgroundColor, backgroundColor),
      fontSize: fallback(this.fontSize, fontSize),
      fontWeight: fallback(this.fontWeight, fontWeight),
      fontStyle: fallback(this.fontStyle, fontStyle),
      letterSpacing: fallback(this.letterSpacing, letterSpacing),
      wordSpacing: fallback(this.wordSpacing, wordSpacing),
      textBaseline: fallback(this.textBaseline, textBaseline),
      height: fallback(this.height, height),
      leadingDistribution: fallback(
        this.leadingDistribution,
        leadingDistribution,
      ),
      locale: fallback(this.locale, locale),
      foreground: fallback(this.foreground, foreground),
      background: fallback(this.background, background),
      shadows: fallback(this.shadows, shadows),
      fontFeatures: fallback(this.fontFeatures, fontFeatures),
      fontVariations: fallback(this.fontVariations, fontVariations),
      decoration: fallback(this.decoration, decoration),
      decorationColor: fallback(this.decorationColor, decorationColor),
      decorationStyle: fallback(this.decorationStyle, decorationStyle),
      decorationThickness: fallback(
        this.decorationThickness,
        decorationThickness,
      ),
      debugLabel: fallback(this.debugLabel, debugLabel),
      fontFamily: fallback(this.fontFamily, fontFamily),
      fontFamilyFallback: fallback(this.fontFamilyFallback, fontFamilyFallback),
      overflow: fallback(this.overflow, overflow),
    );
  }
}

/// Extension methods for [Iterable<Widget>] to insert separators between items.
// extension SeparatedIterable on Iterable<Widget> {
//   /// Inserts a [separator] widget between each item in the iterable.
//   ///
//   /// Returns a new list containing the original widgets with the separator
//   /// inserted between them. If the iterable is empty, returns an empty list.
//   List<Widget> separatedBy(Widget separator) {
//     final result = <Widget>[];
//     final iterator = this.iterator;

//     if (iterator.moveNext()) {
//       result.add(iterator.current);
//       while (iterator.moveNext()) {
//         result
//           ..add(separator)
//           ..add(iterator.current);
//       }
//     }
//     return result;
//   }
// }

/// A highly customizable text input field with support for leading and trailing widgets.
///
/// The [CustomInput] widget provides a fully-featured text input field with
/// comprehensive styling options, placeholder support, and advanced text
/// editing capabilities.
class CustomInput extends StatefulWidget {
  /// Creates a [CustomInput] widget.
  ///
  /// Either [initialValue] or [controller] must be specified, but not both.
  const CustomInput({
    super.key,
    this.initialValue,
    this.placeholder,
    this.controller,
    this.focusNode,
    this.decoration,
    this.undoController,
    TextInputType? keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.cursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20),
    this.dragStartBehavior = DragStartBehavior.start,
    bool? enableInteractiveSelection,
    this.selectionControls,
    this.onPressed,
    this.onPressedAlwaysCalled = false,
    this.onPressedOutside,
    this.mouseCursor,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.contentInsertionConfiguration,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration = TextMagnifierConfiguration.disabled,
    this.selectionColor,
    this.padding,
    this.leading,
    this.trailing,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.placeholderStyle,
    this.alignment,
    this.placeholderAlignment,
    this.inputPadding,
    this.gap,
    this.constraints,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.groupId,
    this.scrollbarPadding,
    this.keyboardToolbarBuilder,
    this.top,
    this.bottom,
    this.onLineCountChange,
    this.editableTextSize,
    this.verticalGap,
    this.theme,
  }) : smartDashesType =
           smartDashesType ??
           (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
       smartQuotesType =
           smartQuotesType ??
           (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
       keyboardType =
           keyboardType ??
           (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
       enableInteractiveSelection =
           enableInteractiveSelection ?? (!readOnly || !obscureText),
       assert(
         initialValue == null || controller == null,
         'Either initialValue or controller must be specified',
       );

  // =============================
  // Core Properties
  // =============================

  /// The initial text value of the input field.
  ///
  /// Only used when [controller] is null.
  final String? initialValue;

  /// The placeholder widget displayed when the input is empty.
  ///
  /// Typically a [Text] widget styled with [placeholderStyle].
  final Widget? placeholder;

  /// Controls the text being edited.
  ///
  /// If null, an internal controller is created using [initialValue].
  final TextEditingController? controller;

  /// Controls whether this text field has keyboard focus.
  ///
  /// If null, an internal focus node is created.
  final FocusNode? focusNode;

  /// Visual decoration for the input field.
  final BoxDecoration? decoration;

  /// Controls undo and redo operations.
  ///
  /// If null, undo functionality is disabled.
  final UndoHistoryController? undoController;

  // =============================
  // Text Input Properties
  // =============================

  /// The type of keyboard to display for text input.
  ///
  /// Defaults to [TextInputType.text] for single-line inputs and
  /// [TextInputType.multiline] for multi-line inputs.
  final TextInputType keyboardType;

  /// The action button on the keyboard.
  ///
  /// Configures the action button text (e.g., "Done", "Next").
  final TextInputAction? textInputAction;

  /// Configures how the platform keyboard capitalizes text.
  final TextCapitalization textCapitalization;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// The strut style to use for the text being edited.
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// The directionality of the text.
  ///
  /// If null, the directionality is inherited from the context.
  final TextDirection? textDirection;

  /// Whether the text field should be read-only.
  ///
  /// Read-only text fields cannot be modified, but may still be selectable.
  final bool readOnly;

  /// Whether to show the cursor.
  ///
  /// The cursor is shown when the text field is focused.
  final bool? showCursor;

  /// Whether this text field should focus itself if nothing else is already
  /// focused.
  final bool autofocus;

  /// Character used for obscuring text when [obscureText] is true.
  final String obscuringCharacter;

  /// Whether to hide the text being edited.
  ///
  /// Commonly used for password fields.
  final bool obscureText;

  /// Whether to enable automatic correction.
  final bool autocorrect;

  /// Smart dashes behavior for the input.
  final SmartDashesType smartDashesType;

  /// Smart quotes behavior for the input.
  final SmartQuotesType smartQuotesType;

  /// Whether to enable suggestions for the current input.
  final bool enableSuggestions;

  /// The maximum number of lines for the text to span.
  ///
  /// Defaults to 1. Null means unlimited number of lines.
  final int? maxLines;

  /// The minimum number of lines to occupy.
  ///
  /// Must be null or greater than zero. If specified, the text input will
  /// expand to at least this many lines.
  final int? minLines;

  /// Whether the text field expands to fill available vertical space.
  ///
  /// If true, the text field will expand to fill its parent.
  final bool expands;

  /// The maximum number of characters (Unicode scalar values) to allow.
  ///
  /// If set, a character counter will be displayed below the field.
  final int? maxLength;

  /// Determines how the [maxLength] limit should be enforced.
  final MaxLengthEnforcement? maxLengthEnforcement;

  // =============================
  // Callbacks
  // =============================

  /// Called when the text being edited changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits editable content.
  final VoidCallback? onEditingComplete;

  /// Called when the user indicates they are done editing.
  final ValueChanged<String>? onSubmitted;

  /// Called for private commands from the input method.
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// Called when the input field is tapped.
  ///
  /// Useful for custom tap handling, especially in read-only mode.
  final GestureTapCallback? onPressed;

  /// Whether [onPressed] should always be called.
  ///
  /// If true, [onPressed] is called even when selection is active.
  final bool onPressedAlwaysCalled;

  /// Called when tapping outside the input field.
  final TapRegionCallback? onPressedOutside;

  /// Called when the line count changes.
  ///
  /// **Note**: This callback won't be called if the input doesn't get a higher
  /// height, such as when the [maxLines] limit has been reached.
  final ValueChanged<int>? onLineCountChange;

  // =============================
  // Input Formatters & Validation
  // =============================

  /// Optional input validation and formatting.
  final List<TextInputFormatter>? inputFormatters;

  // =============================
  // Visual Properties
  // =============================

  /// Whether the text field is interactive.
  ///
  /// If false, the text field is grayed out and disabled.
  final bool enabled;

  /// The width of the cursor.
  final double? cursorWidth;

  /// The height of the cursor.
  final double? cursorHeight;

  /// The radius of the cursor.
  final Radius? cursorRadius;

  /// Whether the cursor will animate from fully transparent to fully opaque.
  final bool? cursorOpacityAnimates;

  /// The color of the cursor.
  final Color? cursorColor;

  /// The height style of the selection highlight.
  final ui.BoxHeightStyle selectionHeightStyle;

  /// The width style of the selection highlight.
  final ui.BoxWidthStyle selectionWidthStyle;

  /// The brightness of the keyboard.
  final Brightness? keyboardAppearance;

  /// The color of the text selection highlight.
  final Color? selectionColor;

  /// Padding around the entire input field.
  final EdgeInsetsGeometry? padding;

  /// Widget displayed before the input field.
  final Widget? leading;

  /// Widget displayed after the input field.
  final Widget? trailing;

  /// Widget displayed above the input field.
  final Widget? top;

  /// Widget displayed below the input field.
  final Widget? bottom;

  /// Main axis alignment for the input row.
  final MainAxisAlignment? mainAxisAlignment;

  /// Cross axis alignment for the input row.
  final CrossAxisAlignment? crossAxisAlignment;

  /// Text style for the placeholder.
  final TextStyle? placeholderStyle;

  /// Alignment of the input field within its container.
  final AlignmentGeometry? alignment;

  /// Alignment of the placeholder within the input field.
  final AlignmentGeometry? placeholderAlignment;

  /// Padding around the editable text within the input field.
  final EdgeInsetsGeometry? inputPadding;

  /// Gap between the input field and its leading/trailing widgets.
  final double? gap;

  /// Gap between the input field and its top/bottom widgets.
  final double? verticalGap;

  /// Constraints applied to the input field.
  final BoxConstraints? constraints;

  /// Size of the underlying [EditableText] widget.
  final Size? editableTextSize;

  /// The color and size of the scrollbar thumb.
  final EdgeInsetsGeometry? scrollbarPadding;

  // =============================
  // Scroll & Interaction Properties
  // =============================

  /// How much space to place around the text when scrolling.
  final EdgeInsets scrollPadding;

  /// Determines the way drag start behavior is handled.
  final DragStartBehavior dragStartBehavior;

  /// Whether to enable user interface affordances for changing the text selection.
  final bool enableInteractiveSelection;

  /// Optional delegate for building the text selection handles and toolbar.
  final TextSelectionControls? selectionControls;

  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  final MouseCursor? mouseCursor;

  /// Controls the scroll position of the text field.
  final ScrollController? scrollController;

  /// The physics of the scrollable text field.
  final ScrollPhysics? scrollPhysics;

  // =============================
  // Platform & Accessibility Features
  // =============================

  /// Hints for autofill services.
  final Iterable<String>? autofillHints;

  /// Configuration for content insertion.
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// How to clip the text field during painting.
  final Clip clipBehavior;

  /// Restoration ID for state restoration.
  final String? restorationId;

  /// Whether scribble input is enabled.
  final bool scribbleEnabled;

  /// Whether stylus handwriting is enabled.
  final bool stylusHandwritingEnabled;

  /// Whether IME personalized learning is enabled.
  final bool enableIMEPersonalizedLearning;

  /// Builder for the context menu.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Configuration for spell checking.
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// Configuration for the magnifier.
  final TextMagnifierConfiguration magnifierConfiguration;

  /// Identifier for grouping multiple text fields.
  final Object? groupId;

  /// Builder for the custom keyboard toolbar.
  final WidgetBuilder? keyboardToolbarBuilder;

  /// Theme configuration for the input field.
  final CustomInputTheme? theme;

  // =============================
  // Constants & Computed Properties
  // =============================

  /// Constant representing no maximum length for the input.
  static const int noMaxLength = -1;

  /// Whether text selection is enabled.
  bool get selectionEnabled => enableInteractiveSelection;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

/// Theme configuration for [CustomInput].
class CustomInputTheme {
  /// Creates a [CustomInputTheme].
  const CustomInputTheme({
    this.style,
    this.placeholderStyle,
    this.cursorColor,
    this.cursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.padding,
    this.inputPadding,
    this.alignment,
    this.placeholderAlignment,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.gap = 8.0,
    this.verticalGap = 0.0,
    this.constraints,
    this.scrollbarPadding,
    this.decoration,
    this.focusedDecoration,
    this.disabledDecoration,
  });

  /// Default text style for the input.
  final TextStyle? style;

  /// Default placeholder text style.
  final TextStyle? placeholderStyle;

  /// Default cursor color.
  final Color? cursorColor;

  /// Default cursor width.
  final double? cursorWidth;

  /// Default cursor height.
  final double? cursorHeight;

  /// Default cursor radius.
  final Radius? cursorRadius;

  /// Default cursor opacity animation behavior.
  final bool? cursorOpacityAnimates;

  /// Default padding around the entire input.
  final EdgeInsetsGeometry? padding;

  /// Default padding around the editable text.
  final EdgeInsetsGeometry? inputPadding;

  /// Default alignment of the input text.
  final AlignmentGeometry? alignment;

  /// Default alignment of the placeholder.
  final AlignmentGeometry? placeholderAlignment;

  /// Default main axis alignment for the input row.
  final MainAxisAlignment? mainAxisAlignment;

  /// Default cross axis alignment for the input row.
  final CrossAxisAlignment? crossAxisAlignment;

  /// Default gap between widgets.
  final double gap;

  /// Default vertical gap between top/bottom widgets.
  final double verticalGap;

  /// Default constraints.
  final BoxConstraints? constraints;

  /// Default scrollbar padding.
  final EdgeInsetsGeometry? scrollbarPadding;

  /// Default decoration.
  final BoxDecoration? decoration;

  /// Decoration when the input is focused.
  final BoxDecoration? focusedDecoration;

  /// Decoration when the input is disabled.
  final BoxDecoration? disabledDecoration;

  /// Creates a copy of this theme with the given fields replaced.
  CustomInputTheme copyWith({
    TextStyle? style,
    TextStyle? placeholderStyle,
    Color? cursorColor,
    double? cursorWidth,
    double? cursorHeight,
    Radius? cursorRadius,
    bool? cursorOpacityAnimates,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? inputPadding,
    AlignmentGeometry? alignment,
    AlignmentGeometry? placeholderAlignment,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    double? gap,
    double? verticalGap,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? scrollbarPadding,
    BoxDecoration? decoration,
    BoxDecoration? focusedDecoration,
    BoxDecoration? disabledDecoration,
  }) {
    return CustomInputTheme(
      style: style ?? this.style,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      cursorOpacityAnimates:
          cursorOpacityAnimates ?? this.cursorOpacityAnimates,
      padding: padding ?? this.padding,
      inputPadding: inputPadding ?? this.inputPadding,
      alignment: alignment ?? this.alignment,
      placeholderAlignment: placeholderAlignment ?? this.placeholderAlignment,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      gap: gap ?? this.gap,
      verticalGap: verticalGap ?? this.verticalGap,
      constraints: constraints ?? this.constraints,
      scrollbarPadding: scrollbarPadding ?? this.scrollbarPadding,
      decoration: decoration ?? this.decoration,
      focusedDecoration: focusedDecoration ?? this.focusedDecoration,
      disabledDecoration: disabledDecoration ?? this.disabledDecoration,
    );
  }

  /// Merges this theme with another theme.
  CustomInputTheme merge(CustomInputTheme? other) {
    if (other == null) return this;
    return copyWith(
      style: other.style,
      placeholderStyle: other.placeholderStyle,
      cursorColor: other.cursorColor,
      cursorWidth: other.cursorWidth,
      cursorHeight: other.cursorHeight,
      cursorRadius: other.cursorRadius,
      cursorOpacityAnimates: other.cursorOpacityAnimates,
      padding: other.padding,
      inputPadding: other.inputPadding,
      alignment: other.alignment,
      placeholderAlignment: other.placeholderAlignment,
      mainAxisAlignment: other.mainAxisAlignment,
      crossAxisAlignment: other.crossAxisAlignment,
      gap: other.gap,
      verticalGap: other.verticalGap,
      constraints: other.constraints,
      scrollbarPadding: other.scrollbarPadding,
      decoration: other.decoration,
      focusedDecoration: other.focusedDecoration,
      disabledDecoration: other.disabledDecoration,
    );
  }
}

/// A widget that disables its child when [disabled] is true.
class _DisabledWrapper extends StatelessWidget {
  /// Creates a [_DisabledWrapper].
  const _DisabledWrapper({required this.disabled, required this.child});

  /// Whether the child should be disabled.
  final bool disabled;

  /// The child widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (disabled) {
      return Opacity(opacity: 0.5, child: IgnorePointer(child: child));
    }
    return child;
  }
}

/// The state for a [CustomInput] widget.
class _CustomInputState extends State<CustomInput>
    with RestorationMixin
    implements TextSelectionGestureDetectorBuilderDelegate {
  // =============================
  // State Management
  // =============================

  late final _focusNode = FocusNode(canRequestFocus: !widget.readOnly);
  late final _hasFocus = ValueNotifier(false);
  late final _controller = RestorableTextEditingController();
  late final _showSelectionHandles = false;
  late final _groupId = UniqueKey();
  late final _scrollController = ScrollController();

  late final _previousLineCount = 0;
  late final _editableTextKey = GlobalKey<EditableTextState>();
  late final _selectionGestureDetectorBuilder =
      _InputSelectionGestureDetectorBuilder(state: this);

  /// Returns the effective focus node.
  FocusNode get effectiveFocusNode => widget.focusNode ?? _focusNode;

  /// Returns the effective text editing controller.
  TextEditingController get effectiveController =>
      widget.controller ?? _controller.value;

  /// Returns the effective scroll controller.
  ScrollController get effectiveScrollController =>
      widget.scrollController ?? _scrollController;

  /// Whether the text field is scrollable.
  bool get isScrollable {
    if (!effectiveScrollController.hasClients) {
      return false;
    }
    return effectiveScrollController.position.maxScrollExtent > 0;
  }

  /// Whether the input is multiline.
  bool get isMultiline => widget.maxLines != 1;

  /// Returns the current [EditableTextState].
  EditableTextState? get _editableText => _editableTextKey.currentState;

  // =============================
  // Lifecycle Methods
  // =============================

  @override
  void initState() {
    super.initState();
    effectiveFocusNode.addListener(_onFocusChange);

    if (widget.controller == null) {
      _controller.value.text = widget.initialValue ?? '';
    }

    if (widget.scrollController == null) {
      _scrollController;
    }
  }

  @override
  void didUpdateWidget(CustomInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update focus node listener
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_onFocusChange);
      effectiveFocusNode.addListener(_onFocusChange);
    }

    // Update controller
    if (widget.controller == null && oldWidget.controller != null) {
      _controller.value.text = oldWidget.controller!.text;
    } else if (widget.controller != null && oldWidget.controller == null) {
      unregisterFromRestoration(_controller);
      _controller.dispose();
    }

    // Update read-only state
    if (widget.readOnly != oldWidget.readOnly) {
      effectiveFocusNode.canRequestFocus = !widget.readOnly;
      if (effectiveFocusNode.hasFocus &&
          effectiveController.selection.isCollapsed) {
        // Update selection handles visibility
      }
    }
  }

  @override
  void dispose() {
    effectiveFocusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) effectiveFocusNode.dispose();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (widget.controller == null) {
      registerForRestoration(_controller, 'controller');
    }
  }

  // =============================
  // Focus Management
  // =============================

  void _onFocusChange() {
    _hasFocus.value = effectiveFocusNode.hasFocus;
  }

  // =============================
  // Selection Management
  // =============================

  void _handleSelectionChanged(
    TextSelection selection,
    SelectionChangedCause? cause,
  ) {
    final willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {});
    }

    // Platform-specific selection behavior
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        if (cause == SelectionChangedCause.longPress) {
          _editableText?.bringIntoView(selection.extent);
        }
    }

    // Hide toolbar on drag for desktop platforms
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) {
          _editableText?.hideToolbar();
        }
    }
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar) {
      return false;
    }

    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }

    if (widget.readOnly && effectiveController.selection.isCollapsed) {
      return false;
    }

    if (!widget.enabled) {
      return false;
    }

    if (cause == SelectionChangedCause.longPress) {
      return true;
    }

    if (effectiveController.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  // =============================
  // Line Count Management
  // =============================

  void _fireOnLineCountChange({
    required String text,
    required BoxConstraints constraints,
    required TextStyle effectiveTextStyle,
    required TextScaler textScaler,
    required double effectiveCursorWidth,
  }) {
    if (widget.onLineCountChange == null) return;

    final span = TextSpan(text: text, style: effectiveTextStyle);

    final textPainter = TextPainter(
      text: span,
      textDirection: Directionality.of(context),
      textScaler: textScaler,
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      textWidthBasis: widget.expands
          ? TextWidthBasis.parent
          : TextWidthBasis.longestLine,
    );

    const caretGap = 1;
    textPainter.layout(
      maxWidth: constraints.maxWidth - caretGap - effectiveCursorWidth,
    );

    final lineMetrics = textPainter.computeLineMetrics();
    final numLines = lineMetrics.length;

    if (numLines != _previousLineCount) {
      late int previousLineCount = 0;
      widget.onLineCountChange!(numLines);
    }
  }

  // =============================
  // TextSelectionGestureDetectorBuilderDelegate Implementation
  // =============================

  @override
  bool get forcePressEnabled {
    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS => true,
      _ => false,
    };
  }

  @override
  bool get selectionEnabled => widget.enableInteractiveSelection;

  @override
  GlobalKey<EditableTextState> get editableTextKey => _editableTextKey;

  @override
  String? get restorationId => widget.restorationId;

  // =============================
  // Build Method
  // =============================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = widget.theme ?? const CustomInputTheme();

    // Determine effective styles and properties
    final effectiveTextStyle = (inputTheme.style ?? const TextStyle())
        .merge(theme.textTheme.bodyMedium)
        .merge(widget.style)
        .copyWith(
          color: widget.enabled
              ? (widget.style?.color ?? theme.colorScheme.onSurface)
              : theme.colorScheme.onSurface.withOpacity(0.38),
        );

    final effectiveCursorColor =
        widget.cursorColor ??
        inputTheme.cursorColor ??
        theme.colorScheme.primary;

    final effectiveCursorWidth =
        widget.cursorWidth ?? inputTheme.cursorWidth ?? 2.0;

    final effectiveCursorHeight =
        widget.cursorHeight ?? inputTheme.cursorHeight;

    final effectiveCursorRadius =
        widget.cursorRadius ?? inputTheme.cursorRadius;

    final effectiveCursorOpacityAnimates =
        widget.cursorOpacityAnimates ??
        inputTheme.cursorOpacityAnimates ??
        false;

    final effectivePadding =
        widget.padding ??
        inputTheme.padding ??
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8);

    final effectiveInputPadding =
        widget.inputPadding ?? inputTheme.inputPadding ?? EdgeInsets.zero;

    final effectivePlaceholderStyle =
        (inputTheme.placeholderStyle ?? const TextStyle(color: Colors.grey))
            .merge(widget.placeholderStyle)
            .fallback(color: theme.colorScheme.onSurface.withOpacity(0.5));

    final defaultAlignment = Directionality.of(context) == TextDirection.rtl
        ? AlignmentDirectional.centerEnd
        : AlignmentDirectional.centerStart;

    final effectivePlaceholderAlignment =
        widget.placeholderAlignment ??
        inputTheme.placeholderAlignment ??
        defaultAlignment;

    final effectiveAlignment =
        widget.alignment ?? inputTheme.alignment ?? defaultAlignment;

    final effectiveMainAxisAlignment =
        widget.mainAxisAlignment ??
        inputTheme.mainAxisAlignment ??
        MainAxisAlignment.start;

    final effectiveCrossAxisAlignment =
        widget.crossAxisAlignment ??
        inputTheme.crossAxisAlignment ??
        CrossAxisAlignment.center;

    final effectiveMouseCursor =
        widget.mouseCursor ?? WidgetStateMouseCursor.textable;

    final effectiveGap = widget.gap ?? inputTheme.gap ?? 8.0;

    final effectiveMaxLengthEnforcement =
        widget.maxLengthEnforcement ??
        LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(
          defaultTargetPlatform,
        );

    final effectiveInputFormatters = <TextInputFormatter>[
      ...?widget.inputFormatters,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(
          widget.maxLength,
          maxLengthEnforcement: effectiveMaxLengthEnforcement,
        ),
    ];

    final textScaler = MediaQuery.textScalerOf(context);

    final maxFontSize = max(
      (effectivePlaceholderStyle.fontSize ?? 0) *
          (effectivePlaceholderStyle.height ?? 0),
      (effectiveTextStyle.fontSize ?? 0) * (effectiveTextStyle.height ?? 0),
    );

    final maxFontSizeScaled = textScaler.scale(maxFontSize);

    final effectiveConstraints =
        widget.constraints ??
        inputTheme.constraints ??
        BoxConstraints(minHeight: maxFontSizeScaled);

    final effectiveGroupId = widget.groupId ?? _groupId;

    final effectiveScrollbarPadding =
        widget.scrollbarPadding ?? inputTheme.scrollbarPadding;

    final effectiveVerticalGap =
        widget.verticalGap ?? inputTheme.verticalGap ?? 0.0;

    // Determine effective decoration based on state
    final effectiveDecoration = _getEffectiveDecoration(inputTheme, theme);

    return ConstrainedBox(
      constraints: effectiveConstraints,
      child: _DisabledWrapper(
        disabled: !widget.enabled,
        child: _selectionGestureDetectorBuilder.buildGestureDetector(
          behavior: HitTestBehavior.translucent,
          child: ValueListenableBuilder(
            valueListenable: _hasFocus,
            builder: (context, focused, _) {
              return ValueListenableBuilder(
                valueListenable: effectiveController,
                builder: (context, textEditingValue, child) {
                  Widget buildEditableText() {
                    final editableText = SizedBox(
                      width: widget.editableTextSize?.width,
                      height: widget.editableTextSize?.height,
                      child: EditableText(
                        showSelectionHandles: _showSelectionHandles,
                        key: _editableTextKey,
                        controller: effectiveController,
                        obscuringCharacter: widget.obscuringCharacter,
                        readOnly: widget.readOnly,
                        focusNode: effectiveFocusNode,
                        onSelectionChanged: _handleSelectionChanged,
                        selectionColor: focused
                            ? widget.selectionColor ??
                                  theme.colorScheme.primary.withOpacity(0.4)
                            : null,
                        selectionHeightStyle: widget.selectionHeightStyle,
                        selectionWidthStyle: widget.selectionWidthStyle,
                        contextMenuBuilder: widget.contextMenuBuilder,
                        selectionControls: widget.selectionControls,
                        mouseCursor: effectiveMouseCursor,
                        enableInteractiveSelection:
                            widget.enableInteractiveSelection,
                        style: effectiveTextStyle,
                        strutStyle: widget.strutStyle,
                        cursorColor: effectiveCursorColor,
                        cursorWidth: effectiveCursorWidth,
                        cursorHeight: effectiveCursorHeight,
                        cursorRadius: effectiveCursorRadius,
                        cursorOpacityAnimates: effectiveCursorOpacityAnimates,
                        backgroundCursorColor: const Color(0xFF9E9E9E),
                        keyboardType: widget.keyboardType,
                        keyboardAppearance:
                            widget.keyboardAppearance ?? theme.brightness,
                        textInputAction: widget.textInputAction,
                        textCapitalization: widget.textCapitalization,
                        autofocus: widget.autofocus,
                        obscureText: widget.obscureText,
                        autocorrect: widget.autocorrect,
                        magnifierConfiguration: widget.magnifierConfiguration,
                        smartDashesType: widget.smartDashesType,
                        smartQuotesType: widget.smartQuotesType,
                        enableSuggestions: widget.enableSuggestions,
                        maxLines: widget.maxLines,
                        minLines: widget.minLines,
                        expands: widget.expands,
                        onChanged: (value) => widget.onChanged?.call(value),
                        onEditingComplete: widget.onEditingComplete,
                        onSubmitted: widget.onSubmitted,
                        onAppPrivateCommand: widget.onAppPrivateCommand,
                        inputFormatters: effectiveInputFormatters,
                        scrollPadding: widget.scrollPadding,
                        dragStartBehavior: widget.dragStartBehavior,
                        scrollPhysics: widget.scrollPhysics,
                        scrollBehavior: ScrollConfiguration.of(
                          context,
                        ).copyWith(scrollbars: false, overscroll: false),
                        autofillHints: widget.autofillHints,
                        clipBehavior: widget.clipBehavior,
                        restorationId: 'editable',
                        scribbleEnabled: widget.scribbleEnabled,
                        stylusHandwritingEnabled:
                            widget.stylusHandwritingEnabled,
                        enableIMEPersonalizedLearning:
                            widget.enableIMEPersonalizedLearning,
                        contentInsertionConfiguration:
                            widget.contentInsertionConfiguration,
                        undoController: widget.undoController,
                        spellCheckConfiguration: widget.spellCheckConfiguration,
                        textAlign: widget.textAlign,
                        onTapOutside: widget.onPressedOutside,
                        rendererIgnoresPointer: true,
                        showCursor: widget.showCursor,
                        groupId: effectiveGroupId,
                      ),
                    );

                    if (widget.onLineCountChange != null) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) {
                              _fireOnLineCountChange(
                                text: effectiveController.text,
                                constraints: constraints,
                                effectiveTextStyle: effectiveTextStyle,
                                textScaler: textScaler,
                                effectiveCursorWidth: effectiveCursorWidth,
                              );
                            }
                          });
                          return editableText;
                        },
                      );
                    }

                    return editableText;
                  }

                  return DecoratedBox(
                    decoration: effectiveDecoration,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.top != null) widget.top!,
                        RawScrollbar(
                          thumbVisibility: isMultiline && isScrollable,
                          controller: effectiveScrollController,
                          padding: effectiveScrollbarPadding?.resolve(
                            Directionality.of(context),
                          ),
                          child: SingleChildScrollView(
                            controller: effectiveScrollController,
                            padding: effectivePadding,
                            physics: widget.scrollPhysics,
                            child: Row(
                              mainAxisAlignment: effectiveMainAxisAlignment,
                              crossAxisAlignment: effectiveCrossAxisAlignment,
                              children: [
                                if (widget.leading != null) widget.leading!,
                                Expanded(
                                  child: AbsorbPointer(
                                    absorbing: widget.readOnly,
                                    child: Padding(
                                      padding: effectiveInputPadding,
                                      child: Stack(
                                        children: [
                                          // Placeholder
                                          if (textEditingValue.text.isEmpty &&
                                              widget.placeholder != null)
                                            Positioned.fill(
                                              child: Align(
                                                alignment:
                                                    effectivePlaceholderAlignment,
                                                child: DefaultTextStyle(
                                                  style:
                                                      effectivePlaceholderStyle,
                                                  child: widget.placeholder!,
                                                ),
                                              ),
                                            ),
                                          // Editable text
                                          RepaintBoundary(
                                            child: UnmanagedRestorationScope(
                                              bucket: bucket,
                                              child: Align(
                                                alignment: effectiveAlignment,
                                                child: buildEditableText(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (widget.trailing != null) widget.trailing!,
                              ].separatedBy(SizedBox(width: effectiveGap)),
                            ),
                          ),
                        ),
                        if (widget.bottom != null) widget.bottom!,
                      ].separatedBy(SizedBox(height: effectiveVerticalGap)),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  BoxDecoration _getEffectiveDecoration(
    CustomInputTheme inputTheme,
    ThemeData theme,
  ) {
    BoxDecoration? baseDecoration;

    if (!widget.enabled) {
      baseDecoration =
          inputTheme.disabledDecoration ??
          inputTheme.decoration ??
          widget.decoration;
    } else if (_hasFocus.value) {
      baseDecoration =
          inputTheme.focusedDecoration ??
          inputTheme.decoration ??
          widget.decoration;
    } else {
      baseDecoration = inputTheme.decoration ?? widget.decoration;
    }

    // Fallback to a simple border if no decoration is provided
    return baseDecoration ??
        BoxDecoration(
          border: Border.all(color: theme.dividerColor),
          borderRadius: BorderRadius.circular(4),
        );
  }
}

/// Builder for text selection gesture detectors in [CustomInput].
class _InputSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _InputSelectionGestureDetectorBuilder({required _CustomInputState state})
    : _state = state,
      super(delegate: state);

  final _CustomInputState _state;

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {
    // Not required for this implementation
  }

  @override
  void onUserTap() {
    _state.widget.onPressed?.call();
  }

  @override
  bool get onUserTapAlwaysCalled => _state.widget.onPressedAlwaysCalled;

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    super.onSingleLongTapStart(details);
    if (delegate.selectionEnabled) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          Feedback.forLongPress(_state.context);
      }
    }
  }
}
