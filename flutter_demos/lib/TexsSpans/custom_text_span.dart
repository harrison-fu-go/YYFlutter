import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class XsCusTextSpan extends StatefulWidget {

  final List<(String, TextStyle? style, {String? link})>
  textInfos; //(text, style, link)
  final ValueChanged<String>? onTapLink; //textPrimaryColor
  final TextAlign? txtAlign;
  final TextStyle? defaultHighlightStyle;
  final TextStyle? defaultNormalStyle;
  const XsCusTextSpan(
      {super.key, required this.textInfos, this.onTapLink, this.txtAlign, this.defaultHighlightStyle, this.defaultNormalStyle});

  @override
  State<StatefulWidget> createState() => _XsCusTextSpanState();
}

class _XsCusTextSpanState extends State<XsCusTextSpan> {
  List<TextSpan> _spans(BuildContext context) {
    TextStyle? highlightStyle = widget.defaultHighlightStyle;
    List<TextSpan> spans = [];
    for ((String, TextStyle?, {String? link}) info in widget.textInfos) {
      if (info.link == null) {
        spans.add(TextSpan(text: info.$1, style: info.$2));
      } else {
        spans.add(TextSpan(
            text: info.$1,
            style: info.$2 ?? highlightStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTapTextEvent(info.link ?? "");
              }));
      }
    }
    return spans;
  }

  onTapTextEvent(String link) {
    widget.onTapLink?.call(link);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text:
      TextSpan(children: _spans(context), style: widget.defaultNormalStyle),
      textAlign: widget.txtAlign ?? TextAlign.left,
    );
  }
}
