import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:just/blocs/cart_bloc/cart_bloc.dart';
import 'package:just/blocs/counter_bloc/counter_bloc.dart';
import 'package:just/blocs/get_pizza_bloc/get_pizza_bloc.dart';
import 'package:just/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:just/blocs/total_bloc/total_bloc.dart';
import 'package:just/screens/cart_screen.dart';
import 'package:just/screens/details_screen.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pizza_repository/pizza_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    void onFocusChanged() {
      //Check if the widget is mouted before accessing context
      if (mounted) {
        if (FocusScope.of(context).isFirstFocus) {
          context.read<CartBloc>().add(GetCartEvent());
        }
      }
    }

    //Register a listener for focus changes
    FocusScope.of(context).addListener(onFocusChanged);

    //Trigger the cart event
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartBloc>().add(GetCartEvent());
    });

    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     FocusScope.of(context).addListener(() {
    //       if (FocusScope.of(context).isFirstFocus) {
    //         context.read<CartBloc>().add(GetCartEvent());
    //       }
    //     });
    //   });
    // }

    // @override
    // void dispose() {
    //   super.dispose();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          children: [
            Image.asset("assets/8.png", scale: 14),
            const SizedBox(width: 5),
            const Text(
              "PIZZA",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -12, end: -12),
              badgeContent: Padding(
                padding: const EdgeInsets.all(2.0),
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartSuccessState) {
                      //   int result = 0;
                      //   for (var i = 0; i < state.cartPizzas.length; i++) {
                      //     result = result + state.cartPizzas[i].itemCount;
                      //   }
                      return Text(
                        "${state.cartPizzas.length}",
                        // state.cartPizzas.length
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    } else if (state is CartProgressState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          '0',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              badgeStyle: const badges.BadgeStyle(
                padding: EdgeInsets.all(3),
              ),
              child: const Icon(
                CupertinoIcons.cart,
              ),
            ),
            //
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            CartBloc(FirebasePizzaRepo())..add(GetCartEvent()),
                      ),
                      BlocProvider(
                        create: (context) => CounterBloc(FirebasePizzaRepo()),
                      ),
                      BlocProvider(
                        create: (context) => TotalBloc(),
                      ),
                    ],
                    child: const CartScreen(),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.arrow_right_to_line),
            onPressed: () {
              context.read<SignInBloc>().add(SignUserOutEvent());
            },
          ),
        ],
      ),
      body:
          //BlocListener<CartBloc, CartState>(
          //   listener: (context, state) {
          //     if (state is CartSuccessState) {
          //       context.read<CartBloc>().add(GetCartEvent());
          //     }
          //   },
          //   child:
          LiquidPullToRefresh(
        height: 300,
        animSpeedFactor: 1,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 800));
          try {
            // ignore: use_build_context_synchronously
            context.read<CartBloc>().add(GetCartEvent());
          } catch (e) {
            log(e.hashCode);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<GetPizzaBloc, GetPizzaState>(
            builder: (context, state) {
              context.read<CartBloc>().add(GetCartEvent());
              if (state is GetPizzaSuccess) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 16,
                    childAspectRatio: 9 / 16,
                  ),
                  itemCount: state.pizzas.length,
                  itemBuilder: (context, int i) {
                    return Material(
                      elevation: 3,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    CartBloc(FirebasePizzaRepo()),
                                child: DetailsScreen(
                                  state.pizzas[i],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /////////////////////////////////
                            Image.network(
                              state.pizzas[i].picture,
                              /////////////////////////////////////
                              // loadingBuilder: (BuildContext context,
                              //     Widget child,
                              //     ImageChunkEvent? loadingProgress) {
                              //   if (!mounted) return child;
                              //   if (loadingProgress == null) {
                              //     return child;
                              //   } else {
                              //     return Center(
                              //       child: CircularProgressIndicator(
                              //         value:
                              //             loadingProgress.expectedTotalBytes !=
                              //                     null
                              //                 ? loadingProgress
                              //                         .cumulativeBytesLoaded /
                              //                     loadingProgress
                              //                         .expectedTotalBytes!
                              //                 : null,
                              //       ),
                              //     );
                              //  }
                              // },
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: state.pizzas[i].isVeg
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: Text(
                                        state.pizzas[i].isVeg
                                            ? "VEG"
                                            : "NON-VEG",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade100,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                        horizontal: 8,
                                      ),
                                      child: Text(
                                        state.pizzas[i].spicy == 1
                                            ? "🌶BALANCE"
                                            : state.pizzas[i].spicy == 2
                                                ? "🌶BLAND"
                                                : "🌶SPICY",
                                        style: TextStyle(
                                          color: state.pizzas[i].spicy == 1
                                              ? Colors.green
                                              : state.pizzas[i].spicy == 2
                                                  ? Colors.orange
                                                  : Colors.redAccent,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                state.pizzas[i].name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                state.pizzas[i].description,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "\$${state.pizzas[i].price - state.pizzas[i].price * state.pizzas[i].discount / 100}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "\$${state.pizzas[i].price}.00",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w700,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      CupertinoIcons.add_circled_solid,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                            AddCartEvent(
                                              pizzaId: state.pizzas[i].pizzaId,
                                              description:
                                                  state.pizzas[i].description,
                                              discount:
                                                  state.pizzas[i].discount,
                                              price: state.pizzas[i].price,
                                              isVeg: state.pizzas[i].isVeg,
                                              macros: state.pizzas[i].macros,
                                              name: state.pizzas[i].name,
                                              picture: state.pizzas[i].picture,
                                              spicy: state.pizzas[i].spicy,
                                              itemCount:
                                                  state.pizzas[i].itemCount,
                                            ),
                                          );
                                      context
                                          .read<CartBloc>()
                                          .add(GetCartEvent());
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is GetPizzaLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(
                  child: Text("Something went wrong..."),
                );
              }
            },
          ),
        ),
      ),
    );
    //);
  }
}
