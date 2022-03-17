import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../../../core/errors/exception.dart';

abstract class PersonDetailsRemoteDataSource {
  Future<List<String>> getPersonImages(int personID);
}

class PersonDetailsRemoteDataSourceImplementation
    extends PersonDetailsRemoteDataSource {
  final http.Client client;

  PersonDetailsRemoteDataSourceImplementation({required this.client});

  @override
  Future<List<String>> getPersonImages(int personID) async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    final baseURL = dotenv.env['TMDB_BASE_URL'];
    final url = baseURL! + 'person/$personID/images?api_key=$apiKey';
    final response = await client.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    Map<String, dynamic> jsonMap = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        final List<String> imagesList = List<String>.from(jsonMap['profiles']
            .map((profile) =>
                'https://image.tmdb.org/t/p/original' + profile['file_path'])
            .toList());
        return imagesList;
      case 404:
      case 401:
        throw ServerException(exceptionMessage: jsonMap['status_message']);
      default:
        throw InternetException();
    }
  }
}
