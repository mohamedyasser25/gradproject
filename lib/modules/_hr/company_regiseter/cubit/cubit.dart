import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_hr/company_regiseter/cubit/states.dart';
import 'package:gp2023/shared/constants/constants.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';

import '../../../../shared/models/companyModel.dart';

class HrRegisterCubit extends Cubit<HrRegisterStates> {
  HrRegisterCubit() : super(HrRegisterInitialState());

  static HrRegisterCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var companyCodeController = TextEditingController();
  var cityValue = defaultDropDownListValue;
  var countriesValue = defaultDropDownListValue;
  var phoneController = TextEditingController();
  var descriptionController = TextEditingController();

  void changeCityState(String cityOut) {
    cityValue = cityOut;
    emit(HrDataChangeCityState());
  }

  void changeCountryState(String countryValue) {
    countriesValue = countryValue;
    emit(HrDataChangeCountryState());
  }

  void companyCreate({
    required String companyName,
    required String companyEmail,
    required String cityValue,
    required String countriesValue,
    required int companyCode,
    required String phone,
    required String description,
  }) {
    CompanyModel model = CompanyModel(
        name: companyName,
        email: companyEmail,
        city: cityValue,
        country: countriesValue,
        taxNumber: companyCode,
        phone: phone,
        description: description);

    CacheHelper.saveData(key: 'companyName', value: companyName);
    print('oooo company name: $companyName');
    print('oooo cached company name: ${CacheHelper.getData(key: 'companyName')}');

    FirebaseFirestore.instance
        .collection('company')
        .add(model.toMap())
        .then((value) {
      CacheHelper.saveData(key: 'companyId', value: value.id);

      emit(HrRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HrRegisterErrorState(error.toString()));
    });
  }
}
