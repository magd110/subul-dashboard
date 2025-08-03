import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);
  // final String _baseUrl = 'http://10.0.2.2:8000/api/'; endPoint: "login"    '$_baseUrl$endPoint',
  final String _baseUrl = 'http://localhost:8000/api/';

  Future<Map<String, dynamic>> getCountries({
    required String endPoint,
    required String token,
  }) async {
    final response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: {"Authorization": token},
      ),
    );
    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> createCountry({
    required String name,
    required String code,
    required String token,
    required String endPoint,
  }) async {
    final response = await _dio.post(
      '$_baseUrl$endPoint',
      data: {
        "name": name,
        "code": code,
      },
      options: Options(
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
      ),
    );

    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> getParcels({
    required String endPoint,
    required String token,
  }) async {
    print('Calling: $_baseUrl$endPoint');

    final response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
      ),
    );

    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> addParcel({
    required String endPoint,
    required String token,
    required String content,
    required int isAllowed,
  }) async {
    final response = await _dio.post(
      '$_baseUrl$endPoint',
      data: {
        "content": content,
        "is_allowed": isAllowed,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );

    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateParcelPermission({
    required int parcelId,
    required String endPoint,
    required String token,
    required int isAllowed,
  }) async {
    print('$_baseUrl$endPoint$parcelId');
    final response = await _dio.post(
      '$_baseUrl$endPoint$parcelId',
      data: {
        "is_allowed": isAllowed,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );

    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> getDeliveryStaff({
    required String token,
    required String endPoint,
  }) async {
    final response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );

    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> createDeliveryStaff({
    required String token,
    required String name,
    required String address,
    required String phone,
    required String jobTitle,
    required String endPoint,
  }) async {
    final response = await _dio.post(
      '$_baseUrl$endPoint',
      data: {
        "name": name,
        "address": address,
        "phone": phone,
        "job_title": jobTitle,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );

    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> deleteDeliveryStaff({
    required String token,
    required String endPoint,
  }) async {
    print("4");
    final response = await _dio.delete(
      '$_baseUrl$endPoint',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateDeliveryStaff({
    required String token,
    required String name,
    required String address,
    required String phone,
    required String jobTitle,
    required String endPoint, // مثال: "update/delivery-staff/1"
    // البيانات الجديدة
  }) async {
    print("Update start...");

    final response = await _dio.put(
      '$_baseUrl$endPoint',
      data: {
        "name": name,
        "address": address,
        "phone": phone,
        "job_title": jobTitle,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    print("Update response: ${response.data}");
    return response.data;
  }

  Future<Map<String, dynamic>> getUsers({
    required String token,
    required String endPoint,
  }) async {
    final response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    print("Response Data: ${response.data}");
    return response.data;
  }

  Future<Map<String, dynamic>> updateUserRole({
    required String token,
    required String endPoint,
    required String newRole,
  }) async {
    final response = await _dio.post(
      '$_baseUrl$endPoint',
      data: {
        "role": newRole,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );

    print("Update Response: ${response.data}");
    return response.data;
  }

  Future<Map<String, dynamic>> deleteUser({
    required int id,
    required String token,
    required String endPoint,
  }) async {
    final response = await _dio.delete(
      '$_baseUrl$endPoint',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> getComplaints({
    required String endPoint,
    required String token,
  }) async {
    print('Calling: $_baseUrl$endPoint');

    final response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );

    print('Response: ${response.data}');
    return response.data;
  }

  Future<Map<String, dynamic>> getComplaintDetails({
    required String endPoint,
    required String token,
  }) async {
    print('Calling: $_baseUrl$endPoint');

    final response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );

    print('Response: ${response.data}');
    return response.data;
  }

  Future<Map<String, dynamic>> addComplaintResponse({
    required String endPoint,
    required String token,
    required String content,
  }) async {
    print('Calling: $_baseUrl$endPoint');
    

    final response = await _dio.post(
      '$_baseUrl$endPoint',
      data: {
        "content": content,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );

    print('Response: ${response.data}');

    return response.data;
  }

  Future<Map<String, dynamic>> login({
    required String endPoint,
    required String email,
    required String password,
  }) async {
    print('Calling: $_baseUrl$endPoint');

    final response = await _dio.post(
      '$_baseUrl$endPoint',
      data: {
        "email": email,
        "password": password,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    print('Response: ${response.data}');

    return response.data;
  }

  Future<Map<String, dynamic>> getDashboardData({
    required String endPoint,
    required String token,
  }) async {
    final response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: {
          "Authorization": token,
        },
      ),
    );
    print(response.data); // للمراقبة
    return response.data;
  }
}
