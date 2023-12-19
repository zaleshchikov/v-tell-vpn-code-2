import 'package:flutter/material.dart';
import 'package:wireguard_flutter/ui/common/colors.dart';
import 'package:wireguard_flutter/ui/common/text_styles.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isActive;

  const Button({
    Key? key,
    required this.text,
    required this.onTap,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        height: 33,
        color: isActive ? PjColors.red : PjColors.grey,
        child: Center(
          child: Text(
            text,
            style: TextStyles.regular16.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
