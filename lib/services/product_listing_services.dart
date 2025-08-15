import 'package:dio/dio.dart';

import '../models/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class ProductServices {
  static Future<ApiResp> getproductList() async {
    dynamic resp;
    await errMAsync(() async {
      resp = await MyDio().get("https://dummyjson.com/products");
    });
    ApiResp respNew = resp is DioError
        ? ApiResp(ok: false, rdata: null, msgs: [], message: '')
        : ApiResp(ok: true, rdata: resp, msgs: [], message: '');

    return respNew;
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
      resp = await MyDio().put("/products/$id", data: data); // Only endpoint path
    });

    ApiResp respNew = resp is DioError
        ? ApiResp(ok: false, rdata: null, msgs: [], message: '')
        : ApiResp(ok: true, rdata: resp, msgs: [], message: '');

    return respNew;
  }


}

