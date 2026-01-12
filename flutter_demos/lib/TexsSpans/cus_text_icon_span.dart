/* File: cus_text_icon_span.dart
 * Created by GYGES.Harrison on 2024/11/11 at 15:15
 * Copyright © 2024 GYGES Limited.
 */
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextWithIcon extends StatefulWidget {
  bool? enable = false;
  Function(String)? onTapCallback;

  final List<TextSpanModel> spanModels;

  RichTextWithIcon({required this.spanModels, this.onTapCallback, super.key});

  @override
  State<RichTextWithIcon> createState() => RichTextWithIconState();
}

class RichTextWithIconState extends State<RichTextWithIcon> {
  late bool enable;
  @override
  void initState() {
    super.initState();
    enable = widget.enable ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(children: getSpans()));
  }

  List<InlineSpan> getSpans() {
    List<InlineSpan> spans = [];
    for (int i = 0; i < widget.spanModels.length; i++) {
      var model = widget.spanModels[i];
      model.onTapCallback = (val) {
        if (val == '') {
          setState(() {
            enable = !enable;
          });
        }
        widget.onTapCallback?.call(val);
      };
      spans.add(model.getSpan(enable: enable));
    }
    return spans;
  }
}

class TextSpanModel {
  TextStyle defaultSty = const TextStyle(color: Colors.black, fontSize: 14);
  bool? isIcon = false;
  String? text;
  String? icon; //Image
  String? iconSel; //Image
  TextStyle? style;
  bool? iNeedTap = false;
  Function(String)? onTapCallback;

  TextSpanModel(
      {this.isIcon,
      this.text,
      this.icon,
      this.iconSel,
      this.style,
      this.iNeedTap});

  InlineSpan getSpan({bool enable = false}) {
    if (isIcon == true) {
      return getIcon(enable: enable);
    } else {
      return getString();
    }
  }

  InlineSpan getIcon({bool enable = false}) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: GestureDetector(
          onTap: iNeedTap == true
              ? () {
                  onTapCallback?.call('');
                }
              : null,
          child: (icon != null)
              ? Image.asset(
                  (enable
                      ? icon!
                      : (iconSel ?? icon!)), // Replace with your image path
                  width: style?.height ?? 10,
                  height: style?.height ?? 10,
                )
              : Icon(
                  enable
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank,
                  color: style?.color ?? Colors.black,
                  size: style?.height ?? 100,
                )),
    );
  }

  InlineSpan getString() {
    return TextSpan(
        text: text ?? '',
        style: style ?? defaultSty,
        recognizer: iNeedTap == true
            ? (TapGestureRecognizer()
              ..onTap = () {
                onTapCallback?.call(text ?? '');
              })
            : null);
  }
}
