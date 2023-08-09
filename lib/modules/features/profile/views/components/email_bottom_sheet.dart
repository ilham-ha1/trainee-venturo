import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmailBottomSheet extends StatefulWidget {
  final String email;

  const EmailBottomSheet({Key? key, required this.email}) : super(key: key);

  @override
  State<EmailBottomSheet> createState() => _EmailBottomSheetState();
}

class _EmailBottomSheetState extends State<EmailBottomSheet> {
  late final TextEditingController controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.r, vertical: 19.r),
      child: Wrap(
        children: [
          16.verticalSpacingRadius,
          Text('Email'.tr, style: Get.textTheme.bodyMedium),
          13.verticalSpacingRadius,
          Row(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: controller,
                    style: Get.textTheme.bodySmall,
                    decoration: InputDecoration(
                      hintText: 'Email'.tr,
                      hintStyle: Get.textTheme.bodySmall,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.w),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.w),
                      ),
                    ),
                    maxLength: 100,
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required'.tr;
                      }
                      return null;
                    },
                  ),
                ),
              ),
              6.horizontalSpace,
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Get.back(result: controller.text);
                  }
                },
                radius: 20.r,
                child: Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}