import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/commons/asset_const.dart';
import '../components/tile_option.dart';
import 'package:trainee/modules/features/profile/controllers/profile_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Profile Screen',
      screenClassOverride: 'Trainee',
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Profile'.tr,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: MainColor.black,
              decoration: TextDecoration.underline),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.r),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AssetConst.bgPattern2),
              fit: BoxFit.fitHeight,
              alignment: Alignment.center),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 25.r),
          children: [
            /// Profile Icon
            Center(
              child: Container(
                width: 170.r,
                height: 170.r,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Stack(
                  children: [
                    Obx(
                      () => Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            ProfileController.to.userDetailData.value.foto !=
                            null,
                        widgetBuilder: (context) => Image.network(
                          ProfileController.to.userDetailData.value.foto,
                          width: 170.r,
                          height: 170.r,
                          fit: BoxFit.cover,
                        ),
                        fallbackBuilder: (context) => Image.asset(
                          AssetConst.bgProfile,
                          width: 170.r,
                          height: 170.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        color: MainColor.primary,
                        child: InkWell(
                          onTap: ProfileController.to.pickImage,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 10.r, bottom: 15.r),
                            child: Text(
                              'Change'.tr,
                              style: GoogleFonts.montserrat(
                                color: MainColor.white,
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            21.verticalSpacingRadius,
            // Info KTP
            Obx(
              () => Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    ProfileController.to.isVerif.value != false,
                widgetBuilder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 20.r,
                    ),
                    7.horizontalSpaceRadius,
                    Text(
                      ' Your have verified your ID card'.tr,
                      style: GoogleFonts.montserrat(
                        color: MainColor.primary,
                        fontSize: 14.sp,
                      ),
                    )
                  ],
                ),
                fallbackBuilder: (context) => InkWell(
                  onTap: ProfileController.to.pickFile,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetConst.icKTP,
                      ),
                      7.horizontalSpaceRadius,
                      Text(
                        'Verify your ID card now!'.tr,
                        style: GoogleFonts.montserrat(
                          color: MainColor.primary,
                          fontSize: 14.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            //info akun
            22.verticalSpacingRadius,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      'Account info'.tr,
                      style: GoogleTextStyle.fw600
                          .copyWith(color: MainColor.primary, fontSize: 16.sp),
                    ),
                  ),
                  14.verticalSpacingRadius,
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.grey[100],
                    ),
                    child: Column(
                      children: [
                        Obx(() => TileOption(
                            title: 'Name'.tr,
                            message: ProfileController
                                    .to.userDetailData.value.nama ??
                                '-',
                            onTap: () {
                              ProfileController.to.updateProfileName();
                            },
                            titleStyle: GoogleTextStyle.fw600.copyWith(
                                color: MainColor.black, fontSize: 14.sp),
                            messageStyle: GoogleTextStyle.fw400.copyWith(
                                color: MainColor.black, fontSize: 14.sp))),
                        Divider(color: Colors.black45, height: 0.5.h),
                        Obx(() => TileOption(
                            title: 'Birth date'.tr,
                            message: ProfileController
                                    .to.userDetailData.value.tglLahir ??
                                '-',
                            onTap: () {
                              ProfileController.to.updateBirthDate();
                            },
                            titleStyle: GoogleTextStyle.fw600.copyWith(
                                color: MainColor.black, fontSize: 14.sp),
                            messageStyle: GoogleTextStyle.fw400.copyWith(
                                color: MainColor.black, fontSize: 14.sp))),
                        Divider(color: Colors.black45, height: 0.5.h),
                        Obx(
                          () => TileOption(
                              title: 'Phone number'.tr,
                              message: ProfileController
                                      .to.userDetailData.value.telepon ??
                                  '-',
                              onTap: () {
                                ProfileController.to.updateProfileNumberPhone();
                              },
                              titleStyle: GoogleTextStyle.fw600.copyWith(
                                  color: MainColor.black, fontSize: 14.sp),
                              messageStyle: GoogleTextStyle.fw400.copyWith(
                                  color: MainColor.black, fontSize: 14.sp)),
                        ),
                        Divider(color: Colors.black45, height: 0.5.h),
                        Obx(
                          () => TileOption(
                              title: 'Email'.tr,
                              message: ProfileController
                                      .to.userDetailData.value.email ??
                                  '-',
                              onTap: () {
                                ProfileController.to.updateProfileEmail();
                              },
                              titleStyle: GoogleTextStyle.fw600.copyWith(
                                  color: MainColor.black, fontSize: 14.sp),
                              messageStyle: GoogleTextStyle.fw400.copyWith(
                                  color: MainColor.black, fontSize: 14.sp)),
                        ),
                        Divider(color: Colors.black45, height: 0.5.h),
                        Obx(
                          () => TileOption(
                              title: 'Change PIN'.tr,
                              message: ProfileController
                                      .to.userDetailData.value.pin ??
                                  '-',
                              onTap: () {
                                ProfileController.to.updateProfilePin();
                              },
                              titleStyle: GoogleTextStyle.fw600.copyWith(
                                  color: MainColor.black, fontSize: 14.sp),
                              messageStyle: GoogleTextStyle.fw400.copyWith(
                                  color: MainColor.black, fontSize: 14.sp)),
                        ),
                        Divider(color: Colors.black45, height: 0.5.h),
                        Obx(
                          () => TileOption(
                              title: 'Change language'.tr,
                              message: ProfileController.to.currentLang.value,
                              onTap: ProfileController.to.updateLanguage,
                              titleStyle: GoogleTextStyle.fw600.copyWith(
                                  color: MainColor.black, fontSize: 14.sp),
                              messageStyle: GoogleTextStyle.fw400.copyWith(
                                  color: MainColor.black, fontSize: 14.sp)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            16.verticalSpacingRadius,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 21.r, vertical: 14.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: Colors.grey[100],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(AssetConst.icReview),
                            9.horizontalSpaceRadius,
                            Text(
                              'Rating'.tr,
                              style: Get.textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(MainRoute.review);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: MainColor.primary,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: MainColor.white, width: 1),
                              borderRadius: BorderRadius.circular(24),
                            )),
                        child: Text("Rate Now".tr),
                      )
                    ],
                  ),
                ),
              ),
            ),
            27.verticalSpacingRadius,

            //device info
            Padding(
              padding: EdgeInsets.only(left: 20.r),
              child: Text(
                'Other info'.tr,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: MainColor.primary,
                ),
              ),
            ),
            14.verticalSpacingRadius,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: Colors.grey[100],
              ),
              child: Column(
                children: [
                  Obx(() => TileOption(
                      title: 'Device Info'.tr,
                      message: ProfileController.to.deviceModel.value)),
                  const Divider(),
                  Obx(() => TileOption(
                      title: 'Device Version'.tr,
                      message: ProfileController.to.deviceVersion.value))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
