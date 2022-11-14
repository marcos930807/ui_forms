import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:reactive_forms/reactive_forms.dart';

import '../input_decoration.dart';

@Deprecated('Use base reactive with [formDecorationInput]')
class DecoratedReactiveTextField<T> extends StatelessWidget {
  /// [ReactiveTextField] Expecific props;
  final String formControlName;
  final void Function(FormControl<dynamic> control)? onSubmitted;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final bool mandatory; //For showing an Asterisk

  /// [TextField] custom props;
  final String? hint;
  final String? label;
  final IconData? icon;
  final TextInputType textType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Color? backgroundColor;
  final bool? obscureText;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;

  const DecoratedReactiveTextField({
    this.onSubmitted,
    required this.formControlName,
    this.validationMessages,
    this.hint,
    this.label,
    this.icon,
    this.backgroundColor,
    this.textType = TextInputType.text,
    this.textInputAction,
    this.inputFormatters,
    this.obscureText,
    this.mandatory = false,
    this.maxLength,
    this.minLines,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<T>(
      formControlName: formControlName,
      onSubmitted: onSubmitted,
      validationMessages: validationMessages,
      inputFormatters: inputFormatters,
      style: const TextStyle(height: 1),
      keyboardType: textType,
      textInputAction: textInputAction,
      cursorColor: Theme.of(context).primaryColor,
      obscureText: obscureText ?? false,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: formCustomDecoration(context).copyWith(
        isDense: true,
        prefixIcon: icon != null
            ? Icon(
                icon,
                size: 22,
                color: Colors.white,
              )
            : null,
        labelText: mandatory ? '$label *' : label,
        hintText: hint,
      ),
    );
  }
}

class DecoratedReactiveObscureTextField extends StatefulWidget {
  /// [ReactiveTextField] Expecific props;
  final String formControlName;
  final void Function(FormControl<dynamic>)? onSubmitted;
  final Map<String, ValidationMessageFunction>? validationMessages;

  /// [TextField] custom props;
  final String? hint;
  final String? label;
  final IconData? icon;
  final TextInputType textType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Color? backgroundColor;

  const DecoratedReactiveObscureTextField({
    this.onSubmitted,
    required this.formControlName,
    this.validationMessages,
    this.hint,
    this.label,
    this.icon,
    this.backgroundColor,
    this.textType = TextInputType.text,
    this.textInputAction,
    this.inputFormatters,
  });

  @override
  _DecoratedReactiveObscureTextFieldState createState() =>
      _DecoratedReactiveObscureTextFieldState();
}

class _DecoratedReactiveObscureTextFieldState
    extends State<DecoratedReactiveObscureTextField> {
  late bool passwordVisible;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  IconButton getToogleButton() {
    return IconButton(
        icon: Icon(
          // Based on passwordVisible state choose the icon
          passwordVisible ? Icons.visibility : Icons.visibility_off,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          // Update the state i.e. toogle the state of passwordVisible variable
          setState(() {
            passwordVisible = !passwordVisible;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<dynamic>(
      formControlName: widget.formControlName,
      onSubmitted: widget.onSubmitted,
      validationMessages: widget.validationMessages,
      inputFormatters: widget.inputFormatters,
      style: const TextStyle(height: 1),
      keyboardType: widget.textType,
      textInputAction: widget.textInputAction,
      cursorColor: Theme.of(context).primaryColor,
      obscureText: !passwordVisible,
      decoration: formCustomDecoration(context).copyWith(
        isDense: true,
        suffixIcon: getToogleButton(),
        prefixIcon: widget.icon != null
            ? Container(
                margin: const EdgeInsets.fromLTRB(2.0, 2.0, 6.0, 2.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withAlpha(130),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Icon(
                  widget.icon,
                  size: 22,
                  color: Colors.white,
                ))
            : null,
        labelText: widget.label,
        hintText: widget.hint,
      ),
    );
  }
}
