import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/checkout/views/componenst/quantity_counter.dart';
import 'package:trainee/modules/global_models/user_order_detail_response.dart';

class DetailOrderCard extends StatelessWidget {
  final Detail detailOrder;

  const DetailOrderCard(this.detailOrder, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.all(7.r),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Row(
        children: [
          /* Image */
          Container(
            height: 90.h,
            width: 90.w,
            margin: EdgeInsets.only(right: 12.w),
            padding: EdgeInsets.all(5.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            child: CachedNetworkImage(
              imageUrl: detailOrder.foto ??
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
              fit: BoxFit.contain,
              errorWidget: (context, _, __) => CachedNetworkImage(
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailOrder.nama ?? '',
                  style: GoogleFonts.montserrat(
                      color: MainColor.black, fontWeight: FontWeight.normal),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  'Rp ${NumberFormat('#,##0', 'id_ID').format(int.parse(detailOrder.total.toString()))}',
                  style: GoogleFonts.montserrat(
                      color: MainColor.primary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 75.r,
            padding: EdgeInsets.only(left: 12.w, right: 5.w),
            child: QuantityCounter(quantity: detailOrder.jumlah ?? 0),
          ),
        ],
      ),
    );
  }
}
