import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just/blocs/cart_bloc/cart_bloc.dart';

import 'package:just/screens/widgets/macro_widget.dart';
import 'package:just/screens/widgets/mybutton_widget.dart';
import 'package:pizza_repository/pizza_repository.dart';

class DetailsScreen extends StatelessWidget {
  final Pizza pizza;

  const DetailsScreen(this.pizza, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.background,
      // leading: IconButton(
      //   onPressed: () {
      //     Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => MultiBlocProvider(
      //           providers: [
      //             BlocProvider(
      //               create: (context) => CartBloc(
      //                 FirebasePizzaRepo(),
      //               ),
      //             ),
      //             BlocProvider(
      //               create: (context) => GetPizzaBloc(
      //                 FirebasePizzaRepo(),
      //               )..add(
      //                   GetPizza(),
      //                 ),
      //             ),
      //             // BlocProvider(
      //             //   create: (context) => SignInBloc(
      //             //     userRepository:
      //             //         context.read<AuthenticationBloc>().userRepository,
      //             //   ),
      //             // ),
      //           ],
      //           child: const HomeScreen(),
      //         ),
      //       ),
      //       (route) => false,
      //     );
      // },
      // icon: const Icon(
      //   CupertinoIcons.arrow_left,
      // ),
      //   ),
      // );
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - (40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(
                    pizza.picture,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            'Truffle Temptation Extravaganda',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              children: [
                                Text(
                                  "\$${pizza.price - pizza.price * (pizza.discount) / 100}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Text(
                                  "\$${pizza.price}.00",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        MyMacroWidget(
                          title: "Calories",
                          value: pizza.macros.calories,
                          icon: FontAwesomeIcons.fire,
                        ),
                        const SizedBox(width: 8),
                        MyMacroWidget(
                          title: "Protein",
                          value: pizza.macros.proteins,
                          icon: FontAwesomeIcons.dumbbell,
                        ),
                        const SizedBox(width: 8),
                        MyMacroWidget(
                          title: "Fat",
                          value: pizza.macros.fat,
                          icon: FontAwesomeIcons.oilWell,
                        ),
                        const SizedBox(width: 8),
                        MyMacroWidget(
                          title: "Carbs",
                          value: pizza.macros.carbs,
                          icon: FontAwesomeIcons.breadSlice,
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      child: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          return MyButton(
                            radius: 15,
                            color: Colors.black,
                            text: "Add to Cart",
                            onPressed: () {
                              context.read<CartBloc>().add(
                                    AddCartEvent(
                                      pizzaId: pizza.pizzaId,
                                      description: pizza.description,
                                      discount: pizza.discount,
                                      price: pizza.price,
                                      isVeg: pizza.isVeg,
                                      macros: pizza.macros,
                                      name: pizza.name,
                                      picture: pizza.picture,
                                      spicy: pizza.spicy,
                                      itemCount: pizza.itemCount,
                                    ),
                                  );
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
