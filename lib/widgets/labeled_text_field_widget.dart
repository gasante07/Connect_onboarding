import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_theme.dart';
import '../config/app_sizes.dart';

/// A scalable labeled text field widget for forms
/// Displays a label above the input field with modern styling
class LabeledTextFieldWidget extends StatefulWidget {
  /// Label text displayed above the field
  final String label;
  
  /// Placeholder/hint text
  final String hintText;
  
  /// Text editing controller
  final TextEditingController controller;
  
  /// Whether this is a password field
  final bool isPassword;
  
  /// Keyboard type
  final TextInputType keyboardType;
  
  /// Validation function
  final String? Function(String?)? validator;
  
  /// Optional icon to display in the field
  final IconData? icon;

  const LabeledTextFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.icon,
  });

  @override
  State<LabeledTextFieldWidget> createState() => _LabeledTextFieldWidgetState();
}

class _LabeledTextFieldWidgetState extends State<LabeledTextFieldWidget> {
  bool _isObscured = true;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: AppTheme.fontSizeMD,
            fontWeight: AppTheme.fontWeightRegular,
            color: AppTheme.textPrimary,
            letterSpacing: AppTheme.letterSpacingNormal,
          ),
        ),
        SizedBox(height: AppTheme.spacingSM),
        // Input field
        Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
              color: Colors.white,
              border: Border.all(
                color: _isFocused
                    ? AppTheme.primary600
                    : AppTheme.borderLight,
                width: _isFocused
                    ? AppSizes.inputBorderWidthFocused
                    : AppSizes.inputBorderWidth,
              ),
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: AppTheme.primary600.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                        spreadRadius: 0,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                        spreadRadius: 0,
                      ),
                    ],
            ),
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.isPassword && _isObscured,
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              style: GoogleFonts.inter(
                fontSize: AppTheme.fontSizeMD,
                fontWeight: AppTheme.fontWeightRegular,
                color: AppTheme.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: GoogleFonts.inter(
                  fontSize: AppTheme.fontSizeMD,
                  color: AppTheme.textTertiary,
                  fontWeight: AppTheme.fontWeightRegular,
                ),
                prefixIcon: widget.icon != null
                    ? Icon(
                        widget.icon,
                        color: _isFocused
                            ? AppTheme.primary600
                            : AppTheme.textTertiary,
                        size: AppSizes.inputIconSize,
                      )
                    : null,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _isObscured
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppTheme.textTertiary,
                          size: AppSizes.inputIconSize,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLG,
                  vertical: AppTheme.spacingLG,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
