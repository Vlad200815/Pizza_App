import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:just/blocs/form_bloc/form_bloc.dart' as my_form_bloc;
import 'package:just/screens/widgets/mybutton_widget.dart';
import 'package:just/screens/widgets/mytextfield_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:uuid/uuid.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String city = "Choose your city";
  String payment = "Choose your payment";

  bool isComplited = false;
  bool isRecall = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController apartamentController = TextEditingController();
  final TextEditingController wishController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.red,
        title: const Text(
          "📃FORM📃",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        color: Colors.red,
        height: 300,
        animSpeedFactor: 1,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 800));
          try {
            // ignore: use_build_context_synchronously
            nameController.clear();
            phoneNumberController.clear();

            houseController.clear();
            apartamentController.clear();

            wishController.clear();
            isComplited = true;
          } catch (e) {
            log(e.hashCode);
          }
        },
        child: BlocBuilder<my_form_bloc.FormBloc, my_form_bloc.FormState>(
          builder: (context, state) {
            BlocBuilder<my_form_bloc.FormBloc, my_form_bloc.FormState>(
              builder: (context, state) {
                if (state is my_form_bloc.FormProgress) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      MyTextField(
                        keyboardType: TextInputType.name,
                        radius: 5,
                        vertical: 5,
                        horizontal: 18,
                        prefixIcon: const Icon(CupertinoIcons.person_alt),
                        hint: "Name",
                        controller: nameController,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 19.0, vertical: 10),
                        child: IntlPhoneField(
                          initialCountryCode: "UA",
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            hintText: "Phone Number",
                          ),
                          controller: phoneNumberController,
                        ),
                      ),
                      // MyTextField(
                      //   vertical: 10,
                      //   horizontal: 18,
                      //   prefixIcon: const Icon(CupertinoIcons.phone_fill),
                      //   hint: "Phone Number",
                      //   controller: phoneNumberController,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(city),
                            leading: const Icon(CupertinoIcons.location_solid),
                            trailing: PopupMenuButton(
                              icon: const Icon(CupertinoIcons.chevron_up),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: "Lviv",
                                  child: SizedBox(
                                    width: 200,
                                    child: Text("Lviv"),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: "Lviv",
                                  child: SizedBox(
                                    width: 200,
                                    child: Text("Lutsk"),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: "Kyiw",
                                  child: SizedBox(
                                    width: 200,
                                    child: Text("Kyiw"),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: "Ternopil",
                                  child: SizedBox(
                                    width: 200,
                                    child: Text("Ternopil"),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: "Riwne",
                                  child: SizedBox(
                                    width: 200,
                                    child: Text("Riwne"),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: "Khmelnytskyi",
                                  child: SizedBox(
                                    width: 200,
                                    child: Text("Khmelnytskyi"),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: "Vinnytsia",
                                  child: SizedBox(
                                    width: 200,
                                    child: Text("Vinnytsia"),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: "Zhytomyr",
                                  child: SizedBox(
                                    width: 200,
                                    child: Text("Zhytomyr"),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: "Chernobyl",
                                  child: SizedBox(
                                    width: 200,
                                    child: Text("Chernobyl"),
                                  ),
                                ),
                              ],
                              onSelected: (String newValue) {
                                setState(() {
                                  city = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              keyboardType: TextInputType.number,
                              radius: 5,
                              vertical: 10,
                              horizontal: 18,
                              hint: "House",
                              controller: houseController,
                              prefixIcon: const Icon(CupertinoIcons.home),
                            ),
                          ),
                          Expanded(
                            child: MyTextField(
                              keyboardType: TextInputType.number,
                              radius: 5,
                              vertical: 10,
                              horizontal: 18,
                              hint: "Apartament",
                              controller: apartamentController,
                              prefixIcon:
                                  const Icon(CupertinoIcons.building_2_fill),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(payment),
                            leading: const Icon(CupertinoIcons.money_dollar),
                            trailing: PopupMenuButton(
                              icon: const Icon(CupertinoIcons.chevron_up),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: "By Cash",
                                  child: SizedBox(
                                    width: 200,
                                    child: Text("By Cash"),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: "By Credit Card",
                                  child: SizedBox(
                                    width: 200,
                                    child: Text("By Credit Card"),
                                  ),
                                ),
                              ],
                              onSelected: (String newValue) {
                                setState(() {
                                  payment = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 18.0,
                          right: 18.0,
                          top: 10,
                        ),
                        child: TextField(
                          controller: wishController,

                          maxLength: 50, //character length allowed,
                          maxLines: 3, // Maximum lines allowed
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            prefix: Icon(
                              CupertinoIcons.wand_stars,
                              size: 30,
                            ),
                            hintText: 'Wish',
                            border:
                                OutlineInputBorder(), // Optional: Add border for visual clarity
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.red,
                              value: isRecall,
                              onChanged: (value) {
                                setState(() {
                                  isRecall = value!;
                                });
                              },
                            ),
                            const Text("Don't recall"),
                          ],
                        ),
                      ),
                      MyButton(
                        radius: 5,
                        color: Colors.red,
                        text: 'Order Now',
                        onPressed: () {
                          int apartamentValue =
                              int.tryParse(apartamentController.text) ?? 0;
                          String wishValue = wishController.text ?? "";
                          context.read<my_form_bloc.FormBloc>().add(
                                my_form_bloc.AddOdrenEvent(
                                  orderId: const Uuid().v1(),
                                  name: nameController.text,
                                  phoneNumber:
                                      int.parse(phoneNumberController.text),
                                  city: city,
                                  house: int.parse(houseController.text),
                                  apartament: apartamentValue,
                                  // int.parse(apartamentController.text) ?? 0,
                                  payment: payment,
                                  wish: wishValue, //wishController.text ?? "",
                                  isRecall: isRecall,
                                ),
                              );
                          nameController.clear();
                          phoneNumberController.clear();

                          houseController.clear();
                          apartamentController.clear();

                          wishController.clear();
                          if (state is my_form_bloc.FormSuccess) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                actions: [
                                  const Text(
                                      "Your order has already been sent\nYour pizza will be deliverd in less than 30 minuts"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Okay"),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
