import 'package:ecommerce_user/utils/constants/colors.dart';
import 'package:ecommerce_user/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    required this.textEditingController,
    this.keyboardType,
    required this.autofocus,
    required this.obsecureText,
    this.hintText,
    this.icondata,
    this.validator,
  });

  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final bool autofocus;
  final bool obsecureText;
  final Widget? icondata;
  final String? hintText;
  final String? Function(String? value)? validator;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = MediaQuery.of(context).platformBrightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.symmetric(
              horizontal: TSizes.spaceBtwItems, vertical: TSizes.sm),
          decoration: BoxDecoration(
            border: Border.all(
              color: currentBrightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
          ),
          child: TextFormField(
            validator: (value) {
              setState(() {
                _errorText = widget.validator?.call(value);
              });
              return null;
            },
            controller: widget.textEditingController,
            keyboardType: widget.keyboardType,
            autofocus: widget.autofocus,
            obscureText: widget.obsecureText,
            decoration: InputDecoration(
              icon: widget.icondata,
              iconColor: const Color.fromARGB(255, 106, 132, 146),
              hintText: widget.hintText,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
            ),
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              _errorText!,
              style: const TextStyle(color: TColors.error),
            ),
          ),
      ],
    );
  }
}
