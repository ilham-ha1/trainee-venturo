import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PinBottomSheet extends StatefulWidget {
  final String pin;

  const PinBottomSheet({Key? key, required this.pin}) : super(key: key);

  @override
  State<PinBottomSheet> createState() => _PinBottomSheetState();
}

class _PinBottomSheetState extends State<PinBottomSheet> {
  late final TextEditingController controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.pin);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.r, vertical: 19.r),
      child: Wrap(
        children: [
          16.verticalSpacingRadius,
          Text('Pin'.tr, style: Get.textTheme.bodyMedium),
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
                      hintText: 'Pin'.tr,
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
                        return 'Pin is required'.tr;
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