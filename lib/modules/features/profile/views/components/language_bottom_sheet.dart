import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/localization/localization.dart';

import 'locale_card.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  Rx<Locale> selectedLocale = Rx<Locale>(Localization.currentLocale);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.r, vertical: 19.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpacingRadius,
          Text('Change language'.tr, style: Get.textTheme.headlineSmall),
          16.verticalSpacingRadius,
          Wrap(
            spacing: 12.r,
            runSpacing: 12.r,
            children: List.generate(
              2,
              (i) {
                return LocaleCard(
                  isSelected: selectedLocale.value == Localization.locales[i],
                  flag: Localization.flags[i],
                  language: Localization.langs[i],
                  onTap: () {
                    selectedLocale(Localization.locales[i]);
                    Get.back(result: Localization.langs[i]);
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}