import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_theme.dart';
import '../config/app_sizes.dart';

class PremiumInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const PremiumInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<PremiumInputField> createState() => _PremiumInputFieldState();
}

class _PremiumInputFieldState extends State<PremiumInputField> {
  bool _isObscured = true;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
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
            width: _isFocused ? 2 : 1.5,
          ),
          boxShadow: _isFocused
              ? [
                  BoxShadow(
                    color: AppTheme.primary600.withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
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
            fontWeight: AppTheme.fontWeightMedium,
            color: AppTheme.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.inter(
              fontSize: AppTheme.fontSizeMD,
              color: AppTheme.textTertiary,
              fontWeight: AppTheme.fontWeightRegular,
            ),
            prefixIcon: Container(
              margin: EdgeInsets.only(left: AppTheme.spacingMD),
              padding: EdgeInsets.all(AppTheme.spacingXS),
              decoration: BoxDecoration(
                color: _isFocused
                    ? AppTheme.primary600.withOpacity(0.1)
                    : AppTheme.backgroundColorGrey100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                widget.icon,
                color: _isFocused
                    ? AppTheme.primary600
                    : AppTheme.textTertiary,
                size: AppSizes.inputIconSize,
              ),
            ),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
              borderSide: BorderSide(
                color: _isFocused
                    ? AppTheme.primary300
                    : AppTheme.borderLight,
                width: _isFocused
                    ? AppSizes.inputBorderWidthFocused
                    : AppSizes.inputBorderWidth,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
              borderSide: BorderSide(
                color: _isFocused
                    ? AppTheme.primary300
                    : AppTheme.borderLight,
                width: _isFocused
                    ? AppSizes.inputBorderWidthFocused
                    : AppSizes.inputBorderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
              borderSide: BorderSide(
                color: AppTheme.primary700,
                width: AppSizes.inputBorderWidthFocused,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
              borderSide: BorderSide(
                color: AppTheme.borderError,
                width: AppSizes.inputBorderWidth,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
              borderSide: BorderSide(
                color: AppTheme.borderErrorFocused,
                width: AppSizes.inputBorderWidthFocused,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

