import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/model/fetch_model/AddressResponse.dart';
import 'package:multivendor_app/model/fetch_model/ApiError.dart';

import 'package:http/http.dart' as http;
import 'package:multivendor_app/model/hook/address.dart';
FetchAddress useFetchAddress(){
  final box=GetStorage();
  String?token=box.read("token");
  final restaurantsItems=useState<List<AddressResponse>?>(null);
  final isLoading=useState<bool>(false);
  final error=useState<Exception?>(null);
  final apiError=useState<ApiError?>(null);
  Future<void> fetchData()async{
    isLoading.value=true;
    try{
      Map<String,String>headers={
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      };
      Uri url=Uri.parse('$appBaseUrl/api/address/all');
      
      final response=await http.get(url,headers: headers);
       print(response.statusCode);
      if(response.statusCode==200){
        
        print(addressResponseFromJson(response.body));
        restaurantsItems.value=addressResponseFromJson(response.body);

      }else{
        apiError.value=apiErrorFromJson(response.body);
      }
    }catch(e){
error.value=e as Exception;
    }finally{
      isLoading.value=false;
    }

  }
  useEffect(() {
    fetchData();
    return null;
  },[]);
  void refetch(){
    isLoading.value=true;
    fetchData();
  }
  return FetchAddress(data: restaurantsItems.value, isLoading: isLoading.value, error: error.value, refetch: refetch);
}