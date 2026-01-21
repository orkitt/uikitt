// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);

      // Grouping: 5-3-3 (adjust if needed)
      if (i == 4 || i == 7) {
        buffer.write(' ');
      }
    }

    final formatted = buffer.toString().trimRight();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class InputField extends StatefulWidget {
  const InputField({super.key, 
    
    this.controller,
    this.initialValue,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.errorText,
    this.inputFormatters,
  }) : assert(
         controller == null || initialValue == null,
         'Cannot provide both controller and initialValue',
       );

  /// 🔍 Named constructor
  factory InputField.password({
    Key? key,
    TextEditingController? controller,
    String hintText = 'Password',
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? errorText,
    bool enabled = true,
  }) {
    return InputField(
      key: key,
      controller: controller,
      hintText: hintText,
      obscureText: true,
      prefixIcon: Icons.lock_outline,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      enabled: enabled,
    );
  }

  factory InputField.search({
    Key? key,
    TextEditingController? controller,
    String hintText = 'Search',
    ValueChanged<String>? onChanged,
    VoidCallback? onFilterTap,
  }) {
    return InputField(
      key: key,
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      prefixIcon: Icons.search,
      suffixIcon: Icons.tune,
      onSuffixTap: onFilterTap,
      keyboardType: TextInputType.text,
    );
  }
  factory InputField.email({
    Key? key,
    TextEditingController? controller,
    String hintText = 'Email',
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? errorText,
    bool enabled = true,
  }) {
    return InputField(
      key: key,
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      prefixIcon: Icons.email_outlined,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      enabled: enabled,
    );
  }
  factory InputField.number({
    Key? key,
    TextEditingController? controller,
    String hintText = 'Number',
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? errorText,
    bool enabled = true,
  }) {
    return InputField(
      key: key,
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      enabled: enabled,
    );
  }
  factory InputField.phone({
    Key? key,
    TextEditingController? controller,
    String hintText = 'Phone number',
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? errorText,
    bool enabled = true,
  }) {
    return InputField(
      key: key,
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      prefixIcon: Icons.phone_outlined,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      enabled: enabled,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        PhoneNumberFormatter(),
      ],
    );
  }

  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final bool obscureText;
  final bool readOnly;
  final bool enabled;

  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  /// ❗ Error without layout jump
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  static const double _height = 32;
  static const double _iconSize = 18;
  static const double _radius = 8;

  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: _height,
          child: TextFormField(
            inputFormatters: widget.inputFormatters,
            controller: widget.controller,
            initialValue: widget.initialValue,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            obscureText: _obscured,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            style: theme.textTheme.bodySmall?.copyWith(height: 1.2),
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.hintText,
              hintStyle: theme.textTheme.bodySmall?.copyWith(
                color: theme.hintColor,
              ),

              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Icon(widget.prefixIcon, size: _iconSize),

              // 👁 Password toggle OR custom suffix
              suffixIcon: _buildSuffixIcon(),

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),

              border: _border(theme.dividerColor),
              enabledBorder: _border(theme.dividerColor),
              focusedBorder: _border(
                hasError ? theme.colorScheme.error : theme.colorScheme.primary,
              ),
              errorBorder: _border(theme.colorScheme.error),
              focusedErrorBorder: _border(theme.colorScheme.error),

              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest,
            ),
          ),
        ),

        // ❗ Error text without height jump
        SizedBox(
          height: 16,
          child: hasError
              ? Padding(
                  padding: const EdgeInsets.only(left: 8, top: 2),
                  child: Text(
                    widget.errorText!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.error,
                      fontSize: 12
                    ),
                  ),
                )
              : null,
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    // Password eye toggle
    if (widget.obscureText) {
      return IconButton(
        padding: EdgeInsets.zero,
        iconSize: _iconSize,
        onPressed: () => setState(() => _obscured = !_obscured),
        icon: Icon(_obscured ? Icons.visibility_off : Icons.visibility),
      );
    }

    // Custom suffix icon
    if (widget.suffixIcon != null) {
      return IconButton(
        padding: EdgeInsets.zero,
        iconSize: _iconSize,
        onPressed: widget.onSuffixTap,
        icon: Icon(widget.suffixIcon),
      );
    }

    return null;
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}

// class InputField extends StatelessWidget {
//   const InputField({
//     super.key,
//     this.controller,
//     this.initialValue,
//     this.hintText,
//     this.onChanged,
//     this.onSubmitted,
//     this.keyboardType,
//     this.textInputAction,
//     this.obscureText = false,
//     this.readOnly = false,
//     this.enabled = true,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.onSuffixTap,
//   }) : assert(
//           controller == null || initialValue == null,
//           'Cannot provide both controller and initialValue',
//         );

//   final TextEditingController? controller;
//   final String? initialValue;
//   final String? hintText;

//   final ValueChanged<String>? onChanged;
//   final ValueChanged<String>? onSubmitted;

//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;

//   final bool obscureText;
//   final bool readOnly;
//   final bool enabled;

//   final IconData? prefixIcon;
//   final IconData? suffixIcon;
//   final VoidCallback? onSuffixTap;

//   static const double _height = 32;
//   static const double _iconSize = 18;
//   static const double _radius = 8;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return SizedBox(
//       height: _height,
//       child: TextFormField(
//         controller: controller,
//         initialValue: initialValue,
//         onChanged: onChanged,
//         onFieldSubmitted: onSubmitted,
//         keyboardType: keyboardType,
//         textInputAction: textInputAction,
//         obscureText: obscureText,
//         readOnly: readOnly,
//         enabled: enabled,
//         style: theme.textTheme.bodySmall?.copyWith(
//           height: 1.2,
//         ),
//         decoration: InputDecoration(
//           isDense: true,
//           hintText: hintText,
//           hintStyle: theme.textTheme.bodySmall?.copyWith(
//             color: theme.hintColor,
//           ),

//           prefixIcon: prefixIcon == null
//               ? null
//               : Icon(prefixIcon, size: _iconSize),

//           suffixIcon: suffixIcon == null
//               ? null
//               : IconButton(
//                   padding: EdgeInsets.zero,
//                   iconSize: _iconSize,
//                   onPressed: onSuffixTap,
//                   icon: Icon(suffixIcon),
//                 ),

//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 8,
//             vertical: 6,
//           ),

//           border: _border(theme.dividerColor),
//           enabledBorder: _border(theme.dividerColor),
//           focusedBorder: _border(theme.colorScheme.primary),
//           disabledBorder: _border(theme.disabledColor),

//           filled: true,
//           fillColor: theme.colorScheme.surfaceContainerHighest,
//         ),
//       ),
//     );
//   }

//   OutlineInputBorder _border(Color color) {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(_radius),
//       borderSide: BorderSide(color: color, width: 1),
//     );
//   }
// }
