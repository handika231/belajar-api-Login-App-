import 'package:belajar_api/model/user_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  static Dio dio = Dio();

  static Future<UserModel> fetchUser() async {
    final data = await dio.get('https://reqres.in/api/users/2');
    return UserModel.fromJson(data.data);
  }
}
