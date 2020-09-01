import 'dart:io';

import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_date.dart';
import 'package:e_coupon/ui/core/widgets/error_toast.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_checkbox.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_field.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_number.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_phone.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_title.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_uid.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/screens/verification/verification_input_data.dart';
import 'package:e_coupon/ui/screens/verification/verification_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';

@injectable
class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  OverlayEntry overlayEntry;
  bool isKeyBoardVisible = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      KeyboardVisibilityNotification().addNewListener(
        onChange: (bool visible) {
          setState(() {
            isKeyBoardVisible = visible;
          });
        },
      );
    }
  }

  Widget _generatePrivateWalletVerificationForm(
      VerificationInputData value, BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 25, bottom: 25, left: 25, right: 25),
      children: <Widget>[
        VerificationFormTitle(
            text: I18n.of(context).verificationPrivateFormTitle),
        VerificationFormField(
          model: value.firstName,
          label: I18n.of(context).verifyFormFieldFirstName,
        ),
        VerificationFormField(
          model: value.lastName,
          label: I18n.of(context).verifyFormFieldLastName,
        ),
        VerificationFormDateField(
          labelText: I18n.of(context).verifyFormFieldBirthday,
          suffixIcon: Icon(Icons.calendar_today),
          initialDate: value.dateOfBirth.input ?? DateTime.parse('2000-01-01'),
          firstDate: DateTime.utc(1900),
          lastDate: DateTime.now(),
          onDateChanged: value.dateOfBirth.setValue,
        ),
        VerificationFormPhoneField(
          model: value.phoneNumber,
          label: I18n.of(context).verifyFormFieldPhoneNumber,
        ),
        VerificationFormField(
          model: value.address,
          label: I18n.of(context).verifyFormFieldAddress,
        ),
        VerificationFormNumberField(
          maxLength: 4,
          model: value.postcode,
          label: I18n.of(context).verifyFormFieldPostcode,
        ),
        VerificationFormField(
          model: value.city,
          label: I18n.of(context).verifyFormFieldCity,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: VerificationFormCheckBox(
            text: I18n.of(context).verificationFilledTruthfully,
            onChanged: value.onIsThruthChanged,
            value: value.isTruth,
          ),
        ),
      ],
    );
  }

  Widget _generateShopWalletVerificationForm(
      VerificationInputData value, BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 25, bottom: 25, left: 25, right: 25),
      children: <Widget>[
        VerificationFormTitle(text: I18n.of(context).verificationShopFormTitle),
        VerificationFormUid(model: value.uid),
        VerificationFormTitle(
            text: I18n.of(context).verificationShopFormCompanyTitle),
        VerificationFormField(
          model: value.companyName,
          label: I18n.of(context).verifyFormFieldCompany,
        ),
        VerificationFormField(
          model: value.address,
          label: I18n.of(context).verifyFormFieldAddress,
        ),
        VerificationFormNumberField(
          maxLength: 4,
          model: value.postcode,
          label: I18n.of(context).verifyFormFieldPostcode,
          keyboardType: TextInputType.number,
        ),
        VerificationFormField(
          model: value.city,
          label: I18n.of(context).verifyFormFieldCity,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: VerificationFormCheckBox(
            text: I18n.of(context).verificationFilledTruthfully,
            onChanged: value.onIsThruthChanged,
            value: value.isTruth,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<VerificationViewModel>(
        model: getIt<VerificationViewModel>(),
        builder: (context, viewModel, child) {
          return ChangeNotifierProvider<VerificationInputData>.value(
            value: viewModel.inputData,
            child: MainLayout(
              isShop: viewModel.isShop,
              title: I18n.of(context).titleFormClaimVerification,
              leadingType: BackButtonType.Close,
              insets: null,
              body: (() {
                if (viewModel.viewState is Error) {
                  Error error = viewModel.viewState;
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    ErrorToast(failure: error.failure).create(context)
                      ..show(context);
                  });
                }
                double bottomInset = 88;
                if (Platform.isIOS) {
                  bottomInset += 34;
                }
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: bottomInset),
                      child: Form(
                        key: viewModel.formKey,
                        child: Consumer<VerificationInputData>(
                          builder: (context, value, child) {
                            return viewModel.isShop
                                ? _generateShopWalletVerificationForm(
                                    value, context)
                                : _generatePrivateWalletVerificationForm(
                                    value, context);
                          },
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(
                              top: 20,
                              bottom:
                                  isKeyBoardVisible && Platform.isIOS ? 10 : 15,
                              left: 25,
                              right: 25),
                          child: Consumer<VerificationInputData>(
                            builder: (context, value, child) {
                              var isError = viewModel.viewState is Loading ||
                                  !value.isValid(viewModel.isShop);

                              return PrimaryButton(
                                isLoading: viewModel.viewState is Loading,
                                text: I18n.of(context)
                                    .buttonFormClaimVerification,
                                isEnabled: !isError,
                                onPressed: () async {
                                  await viewModel.onVerify(
                                      I18n.of(context).successTextVerification,
                                      errorText: I18n.of(context)
                                          .verifyFormErrorVerification);
                                },
                              );
                            },
                          ),
                        ),
                        isKeyBoardVisible && Platform.isIOS
                            ? InputNextView()
                            : Container(),
                      ],
                    )
                  ],
                );
              }()),
            ),
          );
        });
  }
}

class InputNextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ColorStyles.bg_light_gray,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: CupertinoButton(
            padding: EdgeInsets.only(right: 24.0, top: 4.0, bottom: 4.0),
            onPressed: () {
              FocusScope.of(context).nextFocus();
            },
            child: Text(I18n.of(context).verifyFormFieldNextButton,
                style: TextStyle(
                    color: ColorStyles.black, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
