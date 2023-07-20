import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldCustome extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final bool? readOnly;
  final double? width;
  final double? height;
  final bool? isPassword;
  final VoidCallback? onTap;
  final Widget? icon;
  final Function(String)? onChanged;
  final VoidCallback? onFinishEditting;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;

  const TextFieldCustome(
      {Key? key,
      this.controller,
      this.textCapitalization,
      this.hint,
      this.readOnly,
      this.onChanged,
      this.width,
      this.height,
      this.isPassword,
      this.onTap,
      this.icon,
      this.onFinishEditting,
      this.textInputType})
      : super(key: key);
  @override
  State<TextFieldCustome> createState() => _TextFieldCustomeState();
}

class _TextFieldCustomeState extends State<TextFieldCustome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 16.h),
        child: Container(
          width: widget.width ?? 200.w,
          height: widget.height ?? 40.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: _textField(),
        ));
  }

  Widget _textField() {
    return TextField(
      obscureText: widget.isPassword ?? false,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      keyboardType: widget.textInputType ?? TextInputType.text,
      onEditingComplete: widget.onFinishEditting,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      cursorColor: Theme.of(context).highlightColor,
      readOnly: widget.readOnly ?? false,
      style: TextStyle(
          fontSize: 14.sp, color: Colors.amber, fontWeight: FontWeight.bold),
      // obscureText: _isHiddenPassword,
      controller: widget.controller,
      maxLines: 1,
      decoration: decoration(),
    );
  }

  InputDecoration decoration() {
    return InputDecoration(
      icon: widget.icon,
      hintText: widget.hint,
      hintStyle: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.normal,
        fontFamily: "Poppins",
        color: const Color.fromARGB(255, 178, 177, 177),
      ),
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      contentPadding: EdgeInsets.only(
        top: 5.h,
        left: 12.w,
        right: 12.w,
      ),
    );
  }
}
