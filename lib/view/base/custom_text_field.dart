// ignore_for_file: library_private_types_in_public_api


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/dimensions.dart';
import '../../util/styles.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final Function()? onTap;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool suffix;
  final bool readOnly;
  final Color? fillColor;
  final bool changeInputFormatters;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField(
      {Key? key,
      this.hintText = 'Write something...',
      this.controller,
      this.focusNode,
      this.inputFormatters,
      this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.onSubmit,
      this.onChanged,
      this.prefixIcon,
      this.suffixIcon,
      this.readOnly = false,
      this.suffix = false,
      this.capitalization = TextCapitalization.none,
      this.isPassword = false,
      this.fillColor,
      this.changeInputFormatters = false,
      this.onTap})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      //inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: fontSizeRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      autofillHints: widget.inputType == TextInputType.name
          ? [AutofillHints.name]
          : widget.inputType == TextInputType.emailAddress
              ? [AutofillHints.email]
              : widget.inputType == TextInputType.phone
                  ? [AutofillHints.telephoneNumber]
                  : widget.inputType == TextInputType.streetAddress
                      ? [AutofillHints.fullStreetAddress]
                      : widget.inputType == TextInputType.url
                          ? [AutofillHints.url]
                          : widget.inputType == TextInputType.visiblePassword
                              ? [AutofillHints.password]
                              : null,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.changeInputFormatters == true
          ? widget.inputFormatters
          : widget.inputType == TextInputType.phone
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
                ]
              : null,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.5), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                width: 0.5)),
        isDense: true,
        hintText: widget.hintText,
        fillColor: widget.fillColor ?? Theme.of(context).cardColor,
        hintStyle: fontSizeRegular.copyWith(
            fontSize: Dimensions.fontSizeLarge,
            color: Theme.of(context).hintColor),
        filled: true,
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL),
                child:
                    Image.asset(widget.prefixIcon ?? "", height: 20, width: 20),
              )
            : null,
        suffixIcon: widget.suffix
            ? Container(
                width: Dimensions.ICON_SIZE_VERY_SMALL,
                height: Dimensions.ICON_SIZE_VERY_SMALL,
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: Image.asset(
                  widget.suffixIcon ?? '',
                  scale: 4,
                  color: Theme.of(context).primaryColor,
                ))
            : widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor.withOpacity(0.3)),
                    onPressed: _toggle,
                  )
                : null,
      ),
      onSubmitted: (text) => widget.nextFocus != null
          ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null
              ? widget.onSubmit!(text)
              : null,
      onChanged: widget.onChanged,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
