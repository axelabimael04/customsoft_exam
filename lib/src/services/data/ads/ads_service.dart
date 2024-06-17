import 'package:customsoft_exam/src/models/ads_response_model.dart';
import 'package:customsoft_exam/src/services/data/ads/ads_endpoints.dart';

class AdsService {
  static Future<AdsResponseModel?> getAllAds() async {
    try {
      Map<String, dynamic>? resp = await AdsEndpoints.getAllAds();

      if (resp == null) return null;

      AdsResponseModel data = AdsResponseModel.fromMap(resp);

      return data;
    } catch (e) {
      print("Error AdsService.getAllAds $e");
      throw e;
    }
  }
}
