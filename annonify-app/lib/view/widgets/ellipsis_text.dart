import 'package:flutter/material.dart';

class EllipsisText extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextStyle? textStyle;

  const EllipsisText({
    super.key,
    required this.text,
    this.maxLines = 1,
    this.textStyle = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: textStyle,
    );
  }
}
