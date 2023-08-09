import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({
    super.key,
    this.enableShadow,
    required this.id,
    required this.promoName,
    this.discountNominal,
    required this.thumbnailUrl,
    required this.termCondition,
    this.voucherNominal,
    this.width,
  });

  final bool? enableShadow;
  final int id;
  final String? termCondition;
  final String promoName;
  final int? discountNominal;
  final int? voucherNominal;
  final String thumbnailUrl;
  final double? width;

  @override
  Widget build(BuildContext context) {

    final voucherTemplate = [
      Text(
        'Voucher',
        style: Get.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      Text(
        'Rp. $voucherNominal',
        style: Get.textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w800,
          fontSize: 32.sp,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = Colors.white,
        ),
      ),
      Text(
        promoName,
        textAlign: TextAlign.center,
        style: Get.textTheme.labelMedium?.copyWith(
          color: Colors.white,
        ),
      ),
    ];

    final discountTemplate = [
      Text.rich(
        softWrap: true,
        textAlign: TextAlign.center,
        TextSpan(
          text: 'Discount'.tr,
          style: Get.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: ' $discountNominal %',
              style: Get.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1
                  ..color = Colors.white,
              ),
            ),
          ],
        ),
      ),
      Text(
        promoName,
        textAlign: TextAlign.center,
        style: Get.textTheme.labelMedium?.copyWith(
          color: Colors.white,
        ),
      ),
    ];

    return InkWell(
      onTap: () {
        Get.toNamed(MainRoute.promo, arguments: id);
      },
      borderRadius: BorderRadius.circular(15.r),
      child: thumbnailUrl!='' ? Container(
        width: width ?? 282.w,
        height: 188.h,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.r),
          image: DecorationImage(
              image: 
              CachedNetworkImageProvider(
                thumbnailUrl,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor.withAlpha(150),
                BlendMode.srcATop,
              )),
          boxShadow: [
            if (enableShadow == true)
              const BoxShadow(
                color: Color.fromARGB(115, 71, 70, 70),
                offset: Offset(0, 2),
                blurRadius: 8,
              ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: discountNominal == 0 ? discountTemplate: voucherTemplate,
          ),
        ),
      ): 
      Container(
        width: width ?? 282.w,
        height: 188.h,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            if (enableShadow == true)
              const BoxShadow(
                color: Color.fromARGB(115, 71, 70, 70),
                offset: Offset(0, 2),
                blurRadius: 8,
              ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: discountNominal == 0 ? discountTemplate: voucherTemplate,
          ),
        ),
      ),
    );
  }
}