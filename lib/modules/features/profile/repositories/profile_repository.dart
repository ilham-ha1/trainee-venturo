import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_models/user_detail_profile.dart';
import 'package:trainee/utils/services/http_service.dart';

class ProfileRepository {
  // Get list of data profile
  Future<UserDetailData> getUserDetail() async {
    try {
      final detailProfileResponse =
          await HttpService.dioService.getUserDetail();

      if (detailProfileResponse?.userDetailData != null) {
        return detailProfileResponse!.userDetailData!;
      }else{
         throw Exception('Failed request to API');
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      return UserDetailData();
    }
  }
}
