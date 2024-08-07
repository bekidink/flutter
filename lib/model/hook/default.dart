import 'package:flutter/material.dart';
import 'package:multivendor_app/model/fetch_model/AddressResponse.dart';
class FetchDefault{
  final AddressResponse? data;
  final bool isLoading;
  final Exception? error;
  final VoidCallback? refetch;
 
FetchDefault({
  required this.data,
  required this.isLoading,
  required this.error,
  required this.refetch,

 });
}