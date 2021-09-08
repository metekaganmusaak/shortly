import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
   const CustomTextFormField({Key? key, required this.textEditingController,  this.hintText,  this.hintTextColor})
      : super(key: key);

  final TextEditingController textEditingController;
  final String? hintText;
  final Color? hintTextColor;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        keyboardType: TextInputType.url,
        controller: this.textEditingController,
        cursorColor: Color(0xff2BD0D0),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            alignLabelWithHint: false,
            fillColor: Colors.white,
            filled: true,
            hintText: this.hintText,
            hintStyle: TextStyle(
              color: this.hintTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: hintTextColor == Colors.red ? Colors.red : Colors.transparent,
                width: 2,
              ),
              
            ),
            
            contentPadding: EdgeInsets.symmetric(vertical: 17.h)),
      ),
    );
  }
}
