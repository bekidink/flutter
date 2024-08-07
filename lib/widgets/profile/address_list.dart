import 'package:flutter/material.dart';
import 'package:multivendor_app/constants/constants.dart';

import '../../model/fetch_model/AddressResponse.dart';
import 'address_tile.dart';

class AddressList extends StatelessWidget {
  const AddressList({super.key, required this.addresses});
  final List<AddressResponse>addresses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:addresses.length ,
      itemBuilder: (context, index) {
        final address=addresses[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: kGray,
                width: 1
              ),
              top: BorderSide(
                color: kGray,
                width: 1
              )
            )
          ),
          child: AddressTile(address:address),
        );
      },
    );
  }
}