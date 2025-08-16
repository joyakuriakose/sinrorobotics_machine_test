import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';

import '../models/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class ProductServices {
  // static Future<ApiResp> getproductList() async {
  //   dynamic resp;
  //   await errMAsync(() async {
  //     resp = await MyDio().get("https://dummyjson.com/products");
  //   });
  //   ApiResp respNew = resp is DioError
  //       ? ApiResp(ok: false, rdata: null, msgs: [], message: '')
  //       : ApiResp(ok: true, rdata: resp, msgs: [], message: '');
  //
  //   return respNew;
  // }
  static Future<ApiResp> getproductList() async {
    final response = await http.get(Uri.parse("https://dummyjson.com/products"));

    if (response.statusCode == 200) {
      return ApiResp(
        ok: true,
        rdata: jsonDecode(response.body), msgs: [], message: '',
      );
    } else {
      return ApiResp(ok: false, rdata: null, message: '', msgs: []);
    }
  }

  static Future<ApiResp> getProductById(int id) async {
    dynamic resp;
    await errMAsync(() async {
      resp = await MyDio().get("https://dummyjson.com/products/$id");
    });
    ApiResp respNew = resp is DioError
        ? ApiResp(ok: false, rdata: null, msgs: [], message: '')
        : ApiResp(ok: true, rdata: resp, msgs: [], message: '');

    return respNew;
  }


  static Future<ApiResp> updateProduct(int id, Map<String, dynamic> data) async {
    dynamic resp;
    await errMAsync(() async {
      resp = await MyDio().put("/$id", data: data);   // ✅ only ID
    });

    ApiResp respNew = resp is DioError
        ? ApiResp(ok: false, rdata: null, msgs: [], message: '')
        : ApiResp(ok: true, rdata: resp, msgs: [], message: '');

    return respNew;
  }



}

