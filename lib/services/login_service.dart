import 'dart:convert';

import 'package:belajar_api/common/failure.dart';
import 'package:belajar_api/model/login_model/login_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<Either<Failure, LoginModel>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return Right(LoginModel.fromJson(json.decode(response.body)));
      } else {
        return const Left(LoginFailure('Login Failed'));
      }
    } on LoginFailure {
      return const Left(LoginFailure('Login Failed'));
    }
  }
}
