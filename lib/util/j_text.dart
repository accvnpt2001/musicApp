import 'package:flutter/material.dart';

class JText extends StatefulWidget {
  final double? width;
  final GestureTapCallback? tappedText;
  final String? text;
  final EdgeInsets? pin;
  final EdgeInsets? margin;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? backgrounColor;
  final TextDecoration? textDecoration;
  final String? fontFamily;
  final double? lineSpacing;
  final TextOverflow? textOverflow;
  final bool? isSelectable;
  final Color? decorationColor;

  const JText({
    Key? key,
    this.isSelectable,
    this.textOverflow,
    this.decorationColor,
    this.text,
    this.pin,
    this.margin,
    this.textColor,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.backgrounColor,
    this.textDecoration,
    this.tappedText,
    this.width,
    this.fontFamily,
    this.lineSpacing,
  }) : super(key: key);

  @override
  _JTextState createState() => _JTextState();
}

class _JTextState extends State<JText> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.tappedText,
      child: Container(
          width: widget.width,
          padding: widget.pin ?? const EdgeInsets.all(0),
          margin: widget.margin ?? const EdgeInsets.all(0),
          child: (() {
            if (widget.isSelectable ?? false) {
              return selectable();
            } else {
              return textWidget();
            }
          }())),
    );
  }

  Widget textWidget() {
    return Text((widget.text ?? ''),
        textAlign: widget.textAlign ?? TextAlign.left,
        style: TextStyle(
          height: widget.lineSpacing ?? 1,
          fontFamily: widget.fontFamily ?? "Poppins",
          decoration: widget.textDecoration ?? TextDecoration.none,
          decorationColor: widget.decorationColor ?? Colors.transparent,
          decorationThickness: 1.5,
          backgroundColor: widget.backgrounColor ?? Colors.transparent,
          fontWeight: widget.fontWeight ?? FontWeight.normal,
          color: widget.textColor ?? Colors.black,
          fontSize: widget.fontSize ?? 14.0,
        ),
        overflow: widget.textOverflow,
        maxLines: 2);
  }

  Widget selectable() {
    return SelectableText((widget.text ?? ''),
        textAlign: widget.textAlign ?? TextAlign.left,
        style: TextStyle(
          height: widget.lineSpacing ?? 1,
          decoration: widget.textDecoration ?? TextDecoration.none,
          backgroundColor: widget.backgrounColor ?? Colors.transparent,
          fontWeight: widget.fontWeight ?? FontWeight.normal,
          color: widget.textColor ?? Colors.black,
          fontSize: widget.fontSize ?? 14.0,
        ),
        maxLines: null);
  }
}
