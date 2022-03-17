import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../../core/errors/exception.dart';
import 'package:http/http.dart' as http;
import '../models/popular_people_search_result_model.dart';

abstract class PopularPeopleRemoteDataSource {
  Future<PopularPeopleSearchResultModel> getPopularPersonsList(int pageNo);
}

class PopularPeopleRemoteDataSourceImplementation
    extends PopularPeopleRemoteDataSource {
  final http.Client client;

  PopularPeopleRemoteDataSourceImplementation({required this.client});

  @override
  Future<PopularPeopleSearchResultModel> getPopularPersonsList(
      int pageNo) async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    final baseURL = dotenv.env['TMDB_BASE_URL'];
    final url =
        baseURL! + 'person/popular?api_key=$apiKey&language=en-US&page=$pageNo';
    final response = await client.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    Map<String, dynamic> jsonMap = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return PopularPeopleSearchResultModel.fromJson(jsonMap);
      case 404:
      case 401:
        throw ServerException(exceptionMessage: jsonMap['status_message']);
      case 422:
        throw const ServerException(exceptionMessage: 'No more data to load');
      default:
        throw InternetException();
    }
  }
}
