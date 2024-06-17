import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveFieldFormWidget extends StatefulWidget {
  final String placeholder;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final Widget? prefix;
  final String formControlName;
  final bool showPasswordVisualizationButton;
  final bool enableSuffix;
  final int minLines;

  const ReactiveFieldFormWidget({
    required this.placeholder,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.prefix,
    required this.formControlName,
    this.showPasswordVisualizationButton = false,
    required this.enableSuffix,
    this.minLines = 1,
  });

  @override
  State<ReactiveFieldFormWidget> createState() =>
      _ReactiveFieldFormWidgetState();
}

class _ReactiveFieldFormWidgetState extends State<ReactiveFieldFormWidget> {
  FocusNode node = FocusNode();
  bool showPassword = false;

  @override
  void dispose() {
    super.dispose();
    node.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
      ),
      child: ReactiveTextField(
        focusNode: node,
        validationMessages: {
          "required": (error) => "Campo requerido",
          "minLength": (error) => "Caracteres insuficientes",
          "maxLength": (error) => "Límite de caracteres excedido",
          "pattern": (error) => "Campo inválido",
          "compare": (error) => "El campo no coincide"
        },
        formControlName: widget.formControlName,
        textCapitalization: widget.textCapitalization,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ? !showPassword : widget.obscureText,
        style: Theme.of(context).textTheme.bodyMedium,
        minLines: widget.minLines,
        maxLines: widget.minLines,
        decoration: InputDecoration(
          suffixIcon: widget.showPasswordVisualizationButton
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(showPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined))
              : null,
          suffixText:
              widget.enableSuffix && !widget.showPasswordVisualizationButton
                  ? widget.placeholder
                  : null,
          prefixIcon: widget.prefix,
          hintText: widget.placeholder,
          hintStyle: TextStyle(color: Colors.black54),
          helperStyle: TextStyle(color: Colors.black45),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }
}
