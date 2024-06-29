import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class NumberInput extends StatefulWidget {
  const NumberInput({super.key});

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: InternationalPhoneNumberInput(
            formatInput: true,
            textFieldController: controller,
            keyboardType: TextInputType.phone,
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
              useBottomSheetSafeArea: true,
            ),
            validator: (p0) {
              if (p0!.trim().isEmpty) {
                return "Please, enter phone number!";
              }
              return null;
            },
            onInputChanged: (PhoneNumber value) async {},

            // onInputChanged: (PhoneNumber phoneNumber) async {
            //   controller.text = phoneNumber.parseNumber();
            //   print(phoneNumber.phoneNumber);
            // },
            // onInputValidated: (bool value) {
            //   print(value);
            // },
            // selectorConfig: SelectorConfig(
            //   selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            //   useBottomSheetSafeArea: true,
            // ),
            // ignoreBlank: false,
            // autoValidateMode: AutovalidateMode.disabled,
            // selectorTextStyle: TextStyle(color: Colors.black),
            // //initialValue: number,
            // textFieldController: controller,
            // formatInput: true,
            // keyboardType: TextInputType.numberWithOptions(
            //     signed: true, decimal: true),
            // inputBorder: OutlineInputBorder(),
            // onSaved: (PhoneNumber number) {
            //   print('On Saved: $number');
            // },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
