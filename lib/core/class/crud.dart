import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:easycut/core/functions/check_internet.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:path/path.dart';

import 'status_request.dart';

class Crud {
  Future<Either<StatusRequest, dynamic>> getData(String linkUrl) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(Uri.parse(linkUrl));

        if (response.statusCode == 200) {
          try {
            final responseBody = jsonDecode(response.body);
            Logger().i('API GET Response: $responseBody');

            // ✅ Handle both List and Map responses
            if (responseBody is Map<String, dynamic> || responseBody is List) {
              return Right(responseBody);
            } else {
              Logger().e('Unexpected response format: $responseBody');
              return const Left(StatusRequest.serverFailure);
            }
          } catch (e) {
            Logger().e('Error decoding GET response: $e');
            return const Left(StatusRequest.serverFailure);
          }
        } else {
          Logger().e('Server error: ${response.statusCode}');
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        Logger().e('No internet connection');
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      Logger().e('Exception in getData: $e');
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> postData(
      String linkUrl, Map<String, dynamic> data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkUrl),
          body: data,
        );

        Logger().i("Raw Response: ${response.body}"); // Debugging

        if (response.statusCode == 200 || response.statusCode == 201) {
          try {
            final dynamic responseBody = jsonDecode(response.body);

            if (responseBody == null || responseBody is! Map<String, dynamic>) {
              Logger().e('Invalid JSON format or null response');
              return const Left(StatusRequest.serverFailure);
            }

            Logger().i('Decoded Response: $responseBody');

            // Handle 'salon' key safely
            if (responseBody.containsKey('salon') &&
                responseBody['salon'] != null &&
                responseBody['salon'] == false) {
              Logger().w('No salons found for the query.');
              return const Left(StatusRequest.serverFailure);
            }

            // Handle 'status' safely
            final dynamic status = responseBody['status'];
            final dynamic message = responseBody['message'];

            if (status == null || status is! String || message != null) {
              Logger().d(
                  "Error: 'status' is null or not a String. Message: ${message ?? 'No message available'}");
              return const Left(StatusRequest.success);
            }

            return Right(responseBody);
          } catch (e) {
            Logger().e('Error decoding response: $e');
            return const Left(StatusRequest.serverFailure);
          }
        } else {
          Logger().e('Server error: ${response.statusCode}');
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        Logger().e('No internet connection');
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      Logger().e('Exception in postData: $e');
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> postDataWithFile(
    String linkUrl,
    Map<String, dynamic> data,
    File file,
  ) async {
    try {
      if (await checkInternet()) {
        var request = http.MultipartRequest(
          "POST",
          Uri.parse(linkUrl),
        );

        var length = await file.length();

        var stream = http.ByteStream(file.openRead());

        var multipartFile = http.MultipartFile(
          "file",
          stream,
          length,
          filename: basename(file.path),
        );

        request.files.add(multipartFile);
        data.forEach((key, value) {
          request.fields[key] = value;
        });
        var myRequest = await request.send();
        var response = await http.Response.fromStream(myRequest);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }
}
