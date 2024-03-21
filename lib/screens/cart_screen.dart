import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just/blocs/cart_bloc/cart_bloc.dart';
import 'package:just/blocs/counter_bloc/counter_bloc.dart';
import 'package:just/blocs/form_bloc/form_bloc.dart';
import 'package:just/blocs/total_bloc/total_bloc.dart';
import 'package:just/screens/order_details.dart';
import 'package:just/screens/widgets/mybutton_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pizza_repository/pizza_repository.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text(
          "🛒CART🛒",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        height: 300,
        animSpeedFactor: 1,
        color: Colors.teal,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 800));
          try {
            // ignore: use_build_context_synchronously
            context.read<CartBloc>().add(GetCartEvent());
          } catch (e) {
            log(e.hashCode);
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartSuccessState) {
              context
                  .read<TotalBloc>()
                  .add(TotalSumEvent(pizzas: state.cartPizzas));
              if (state.cartPizzas.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "WHAT ARE YOU IF CAN'T DECIDE WHAT KIND OF PIZZA TO GET?",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 12),
                      ),
                      Text(
                        "YOU'RE indeSLICEsive",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 12,
                          childAspectRatio: 16 / 9,
                        ),
                        itemCount: state.cartPizzas.length,
                        itemBuilder: (context, int i) {
                          final price = state.cartPizzas[i].price *
                                  state.cartPizzas[i].itemCount -
                              ((state.cartPizzas[i].price *
                                      state.cartPizzas[i].itemCount) *
                                  (state.cartPizzas[i].discount) /
                                  100);
                          return Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: Image.network(
                                        state.cartPizzas[i].picture,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: state.cartPizzas[i].isVeg
                                                  ? Colors.green
                                                  : Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4,
                                                horizontal: 8,
                                              ),
                                              child: Text(
                                                state.cartPizzas[i].isVeg
                                                    ? "VEG"
                                                    : "NON-VEG",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4,
                                                horizontal: 8,
                                              ),
                                              child: Text(
                                                state.cartPizzas[i].spicy == 1
                                                    ? "🌶BALANCE"
                                                    : state.cartPizzas[i]
                                                                .spicy ==
                                                            2
                                                        ? "🌶BLAND"
                                                        : "🌶SPICY",
                                                style: TextStyle(
                                                  color: state.cartPizzas[i]
                                                              .spicy ==
                                                          1
                                                      ? Colors.green
                                                      : state.cartPizzas[i]
                                                                  .spicy ==
                                                              2
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
                                  ],
                                ),
                                SizedBox(
                                  width: 174,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 26),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          state.cartPizzas[i].name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          state.cartPizzas[i].description,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                //${state.cartPizzas[i].price * state.cartPizzas[i].itemCount - ((state.cartPizzas[i].price * state.cartPizzas[i].itemCount) * (state.cartPizzas[i].discount) / 100)}
                                                Text(
                                                  "\$${price.toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                    fontSize: 18,
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
                                                  "\$${(state.cartPizzas[i].price * state.cartPizzas[i].itemCount)}.00",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey.shade500,
                                                    fontWeight: FontWeight.w700,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              context.read<CounterBloc>().add(
                                                    AddItemEvent(
                                                      pizzaId: state
                                                          .cartPizzas[i]
                                                          .pizzaId,
                                                    ),
                                                  );
                                              context.read<CartBloc>().add(
                                                    GetCartEvent(),
                                                  );
                                            },
                                            icon: const Icon(
                                              CupertinoIcons.add,
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                            ),
                                            /////////////////////////
                                            child: Text(
                                                "${state.cartPizzas[i].itemCount}"),
                                          ),
                                          ////////////////////////////////
                                          // state.cartPizzas[i].itemCount
                                          ///////////////////////////////

                                          IconButton(
                                            onPressed: () {
                                              context.read<CounterBloc>().add(
                                                    SubItemEvent(
                                                      pizzaId: state
                                                          .cartPizzas[i]
                                                          .pizzaId,
                                                    ),
                                                  );
                                              context
                                                  .read<CartBloc>()
                                                  .add(GetCartEvent());
                                            },
                                            icon: const Icon(
                                              CupertinoIcons.minus,
                                              size: 20,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              context.read<CartBloc>().add(
                                                    DeleteCartPizzasEvent(
                                                      pizzaId: state
                                                          .cartPizzas[i]
                                                          .pizzaId,
                                                    ),
                                                  );
                                              context
                                                  .read<CartBloc>()
                                                  .add(GetCartEvent());
                                            },
                                            icon: const Icon(
                                              CupertinoIcons
                                                  .clear_circled_solid,
                                              size: 25,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Total Sum:",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        BlocBuilder<TotalBloc, TotalSumState>(
                          builder: (context, state) {
                            return Text(
                              "${state.total.toStringAsFixed(2)}\$",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    MyButton(
                      radius: 15,
                      text: "Fill Form",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => FormBloc(
                                FirebasePizzaRepo(),
                              ),
                              child: const OrderDetails(),
                            ),
                          ),
                        );
                      },
                      color: Colors.black,
                    ),
                  ],
                ),
              );
            } else if (state is CartProgressState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("Something Went Wrong!!!"),
              );
            }
          },
        ),
      ),
    );
  }
}
