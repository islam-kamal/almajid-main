import 'dart:convert';

import 'package:almajidoud/Bloc/ShippmentAddress_Bloc/shippment_address_bloc.dart';
import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/Model/ShipmentAddressModel/client/address_model.dart';

class ShipmentAddressRepository {
  Dio dio = new Dio();

  // use to make Add Shipping and billing address for client and guest
  Future<GuestShipmentAddressModel> add_addresses(
      {BuildContext context}) async {
    var _post_code;
    Map<String, String> postcode_ities = {'Riyadh': '11564', 'Abha': '61321'};
    postcode_ities.forEach((key, value) {
      if (key == 'Abha') {
        _post_code = value;
      }
    });

    try {
      // print("await sharedPreferenceManager.readString(CachingKey.CHOSSED_ADDRESS_ID) : ${StaticData.chossed_address_id}");
      final response = await dio.post(
          StaticData.vistor_value == 'visitor'
              ? "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/guest-carts/${StaticData.vistor_value == 'visitor' ? await sharedPreferenceManager.readString(CachingKey.GUEST_CART_QUOTE) : await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/shipping-information"
              : "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/carts/mine/shipping-information",
          data: {
            "addressInformation": {
              "shipping_address": {
                "customer_address_id" :  StaticData.vistor_value == 'visitor'
                    ? null : StaticData.chossed_address_id,
                "region": await sharedPreferenceManager.readString(
                    translator.activeLanguageCode == 'ar'
                        ? CachingKey.REGION_AR
                        : CachingKey.REGION_EN),
                "region_id": await sharedPreferenceManager
                    .readString(CachingKey.REGION_ID),
                "region_code": await sharedPreferenceManager.readString(
                    translator.activeLanguageCode == 'ar'
                        ? CachingKey.REGION_AR
                        : CachingKey.REGION_EN),
                "country_id": MyApp.app_location == 'sa' ? "SA"
                    :   MyApp.app_location == 'uae' ? "AE" : "KW",
                "street": ["${shipmentAddressBloc.street_controller.value}"],
                "postcode": "10577",
                "city": await sharedPreferenceManager.readString(
                    translator.activeLanguageCode == 'ar'
                        ? CachingKey.REGION_AR
                        : CachingKey.REGION_EN),
                "firstname":
                    "${shipmentAddressBloc.frist_name_controller.value}",
                "lastname": "${shipmentAddressBloc.last_name_controller.value}",
                "email": StaticData.vistor_value == 'visitor'
                    ? "${shipmentAddressBloc.email_controller.value}"
                    : await sharedPreferenceManager
                        .readString(CachingKey.EMAIL),
                "telephone": "${shipmentAddressBloc.phone_controller.value}"
              },
              "billing_address": {
                "customer_address_id" :  StaticData.vistor_value == 'visitor'
                    ? null : StaticData.chossed_address_id,
                "region": await sharedPreferenceManager.readString(
                    translator.activeLanguageCode == 'ar'
                        ? CachingKey.REGION_AR
                        : CachingKey.REGION_EN),
                "region_id": await sharedPreferenceManager
                    .readString(CachingKey.REGION_ID),
                "region_code": await sharedPreferenceManager.readString(
                    translator.activeLanguageCode == 'ar'
                        ? CachingKey.REGION_AR
                        : CachingKey.REGION_EN),
                "country_id": MyApp.app_location == 'sa' ? "SA"
                    :   MyApp.app_location == 'uae' ? "AE" : "KW",
                "street": ["${shipmentAddressBloc.street_controller.value}"],
                "postcode": "10577",
                "city": await sharedPreferenceManager.readString(
                    translator.activeLanguageCode == 'ar'
                        ? CachingKey.REGION_AR
                        : CachingKey.REGION_EN),
                "firstname":
                    "${shipmentAddressBloc.frist_name_controller.value}",
                "lastname": "${shipmentAddressBloc.last_name_controller.value}",
                "email": StaticData.vistor_value == 'visitor'
                    ? "${shipmentAddressBloc.email_controller.value}"
                    : await sharedPreferenceManager
                        .readString(CachingKey.EMAIL),
                "telephone": "${shipmentAddressBloc.phone_controller.value}"
              },
              "shipping_carrier_code": "flatrate",
              "shipping_method_code": "flatrate"
            }
          },
          options: Options(
              headers: StaticData.vistor_value == 'visitor'
                  ? Map<String, String>.from({})
                  : Map<String, String>.from({
                      'Authorization':
                          'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
                      'content-type': 'application/json'
                    })));
      if (response.statusCode == 200) {
        if (StaticData.vistor_value != 'visitor' &&
            !StaticData.chosse_address_status) {


          final newAddressresponse = await dio.put(
              "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/customers/me/address",
              data: {
                "customer_id": await sharedPreferenceManager
                    .readInteger(CachingKey.CUSTOMER_ID),
                "address": {
                  "customer_id": await sharedPreferenceManager
                      .readInteger(CachingKey.CUSTOMER_ID),
                  "region": {
                    "region_code": await sharedPreferenceManager.readString(
                        translator.activeLanguageCode == 'ar'
                            ? CachingKey.REGION_AR
                            : CachingKey.REGION_EN),
                    "region": await sharedPreferenceManager.readString(
                        translator.activeLanguageCode == 'ar'
                            ? CachingKey.REGION_AR
                            : CachingKey.REGION_EN),
                    "region_id": await sharedPreferenceManager
                        .readString(CachingKey.REGION_ID),
                  },
                  "region_id": await sharedPreferenceManager
                      .readString(CachingKey.REGION_ID),
                  "country_id": MyApp.app_location == 'sa' ? "SA"
                      :   MyApp.app_location == 'uae' ? "AE" : "KW",
                  "street": ["${shipmentAddressBloc.street_controller.value}"],
                  "telephone": "${shipmentAddressBloc.phone_controller.value}",
                  "postcode": "10577",
                  "city": await sharedPreferenceManager.readString(
                      translator.activeLanguageCode == 'ar'
                          ? CachingKey.REGION_AR
                          : CachingKey.REGION_EN),
                  "firstname":
                      "${shipmentAddressBloc.frist_name_controller.value}",
                  "lastname":
                      "${shipmentAddressBloc.last_name_controller.value}",
                }
              },
              options: Options(
                  headers: Map<String, String>.from({
                'Authorization':
                    'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
                'content-type': 'application/json'
              })));
          if (newAddressresponse.statusCode == 200) {
            final jsonData = response.data;
            GuestShipmentAddressModel guestShipmentAddressModel =
                GuestShipmentAddressModel.fromJson(
                    Map<String, dynamic>.from(jsonData));
            return guestShipmentAddressModel;
          } else {
            errorDialog(
                context: context, text: newAddressresponse.data['message']);
          }
        }
        else {
          final jsonData = response.data;
          GuestShipmentAddressModel guestShipmentAddressModel =
              GuestShipmentAddressModel.fromJson(
                  Map<String, dynamic>.from(jsonData));
          return guestShipmentAddressModel;
        }
      } else {
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
    //  errorDialog(context: context, text: e.toString());
    }
  }

  Future<List<AddressModel>> get_all_saved_addresses({BuildContext context}) async {
    try {
      final response = await dio.get(
          '${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/customers/me/address/search?customer_id=${await sharedPreferenceManager.readInteger(CachingKey.CUSTOMER_ID)}&searchCriteria',
          options: Options(
              headers: Map<String, String>.from(
            {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization':
                  'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
            },
          )));
      if (response.statusCode == 200) {
        final jsonresponse = response.data['items'];
        List<AddressModel> temp = (jsonresponse as List)
            .map((f) => AddressModel.fromJson(f))
            .toList();
        StaticData.saved_addresses_count = temp.length;
        return temp;
      } else {
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      errorDialog(
          context: context,
          text: "The consumer isn't authorized to access %resources.");
    }
  }

  Future<AddressModel> add_new_address({BuildContext context}) async {
    return NetworkUtil.internal()
        .put(AddressModel(), Urls.BASE_URL + '/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/customers/me/address',
            headers: Map<String, String>.from({
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization':
                  'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
            }),
            body: {
          "customer_id":
              await sharedPreferenceManager.readInteger(CachingKey.CUSTOMER_ID),
          "address": {
            "customer_id": await sharedPreferenceManager
                .readInteger(CachingKey.CUSTOMER_ID),
            "region": {
              "region_code": await sharedPreferenceManager.readString(
                  translator.activeLanguageCode == 'ar'
                      ? CachingKey.REGION_AR
                      : CachingKey.REGION_EN),
              "region": await sharedPreferenceManager.readString(
                  translator.activeLanguageCode == 'ar'
                      ? CachingKey.REGION_AR
                      : CachingKey.REGION_EN),
              "region_id": await sharedPreferenceManager
                  .readString(CachingKey.REGION_ID),
            },
            "region_id":
                await sharedPreferenceManager.readString(CachingKey.REGION_ID),
            "country_id": "SA",
            "street": ["${shipmentAddressBloc.street_controller.value}"],
            "telephone": "${shipmentAddressBloc.phone_controller.value}",
            "postcode": "10577",
            "city": await sharedPreferenceManager.readString(
                translator.activeLanguageCode == 'ar'
                    ? CachingKey.REGION_AR
                    : CachingKey.REGION_EN),
            "firstname": "${shipmentAddressBloc.frist_name_controller.value}",
            "lastname": "${shipmentAddressBloc.last_name_controller.value}",
          }
        });
  }

  Future<AddressModel> get_addresss_details({var address_id}) async {
    return NetworkUtil().get(AddressModel(),
        "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest//V1/mstore/customers/me/address/${address_id}",
        headers: Map<String, String>.from(
          {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
          },
        ));
  }
}

final shipmentAddressRepository = ShipmentAddressRepository();
