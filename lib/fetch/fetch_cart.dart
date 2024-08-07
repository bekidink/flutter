import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/model/fetch_model/AddressResponse.dart';
import 'package:multivendor_app/model/fetch_model/ApiError.dart';

import 'package:http/http.dart' as http;
import 'package:multivendor_app/model/fetch_model/cartRequest.dart';
import 'package:multivendor_app/model/fetch_model/cartResponse.dart';
import 'package:multivendor_app/model/hook/address.dart';
import 'package:multivendor_app/model/hook/cart.dart';
FetchCart useFetchCart(){
  final box=GetStorage();
   String?token=box.read("token");
  final cartItems=useState<List<CartResponse>?>(null);
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
      Uri url=Uri.parse('$appBaseUrl/api/cart');
      
      final response=await http.get(url,headers: headers);
       print(response.body);
      if(response.statusCode==200){
        
        print(cartResponseFromJson(response.body));
        cartItems.value=cartResponseFromJson(response.body);

      }else{
        apiError.value=apiErrorFromJson(response.body);
      }
    }catch(e){
      print(e);
// error.value=e as Exception ;
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
  return FetchCart(data: cartItems.value, isLoading: isLoading.value, error: error.value, refetch: refetch);
}