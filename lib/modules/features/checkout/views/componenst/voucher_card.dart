import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/modules/features/checkout/controllers/checkout_controller.dart';
import 'package:trainee/modules/global_models/user_voucher_response.dart';

class VoucherCard extends StatelessWidget {
  const VoucherCard(
      {super.key, required this.voucher, this.onTap, required this.index});

  final Voucher voucher;
  final void Function()? onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx( () =>
       InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      voucher.nama ?? "",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Checkbox(
                    value:
                        CheckoutController.to.selectedVoucher.value.idVoucher ==
                            voucher.idVoucher,
                    onChanged: (value) {
                      CheckoutController.to.selectedVoucher(voucher);
                      CheckoutController.to.addDataVoucher();
                      CheckoutController.to.manageVoucherCheckBox(
                          index, value ?? false);
                    })
              ],
            ),
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.r),
                ),
                image: DecorationImage(
                  image: voucher.infoVoucher != null
                      ? CachedNetworkImageProvider(voucher.infoVoucher!)
                      : const CachedNetworkImageProvider(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
