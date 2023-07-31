import 'package:dio/dio.dart';
import 'package:flutter_appwork_crud/models/request_model_users.dart';
import 'package:flutter_appwork_crud/models/users_model.dart';

class UsersService {
  late Dio _dio;

  String baseUrl = 'https://capekngoding.com/6281389616774/api/users';

  UsersService() {
    _dio = Dio();
  }

  // Get Data Users
  Future<UsersModel> getAll() async {
    var response = await _dio.get(
      baseUrl,
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    return UsersModel.fromJson(response.data);
  }

  // Post Data Users
  Future<void> addData(ReqUser request) async {
    await _dio.post(
      baseUrl,
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      data: {
        "first_name": request.firstName,
        "last_name": request.lastName,
        "email": request.email,
      },
    );
  }

  //Update Data Users
  Future<void> updateData(int id, ReqUser reqUser) async {
    var response = await _dio.post(
      "$baseUrl/$id",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      data: {
        "first_name": reqUser.firstName,
        "last_name": reqUser.lastName,
        "email": reqUser.email,
      },
    );
    return response.data;
    //Map obj = response.data;
  }

  // Delete User Data
  Future<void> deleteData(int id) async {
    await _dio.delete(
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      "$baseUrl/$id",
    );

    //print(response.statusCode);
  }
}
