import 'package:dispatcher/api/articles/responses/get_everything_response.dart';
import 'package:dispatcher/constants/constants.dart';

import '../../network/dio_client.dart';

class ArticlesApi {

  static const _everything = 'everything';
  static const _topHeadlines = 'top-headlines';

  late final DioClient dioClient = DioClient.instance;

  ArticlesApi();

  Future<GetEverythingResponse> getEverything() async {
    try {
      final response = await dioClient.get(
          _everything,
          queryParameters: {'apiKey': Constants.apiKey, 'q': ''}
      );
      return response as GetEverythingResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetEverythingResponse> getTopHeadlines() async {
    try {
      final response = await dioClient.get(
          _topHeadlines,
          queryParameters: {
            'apiKey': Constants.apiKey,
            'country': 'us',
          }
      );
      return GetEverythingResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }



}