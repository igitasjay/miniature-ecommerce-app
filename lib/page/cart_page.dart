import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    // final cart = Provider.of<CartProvider>(context).cart; . . . same as above.
    return cart.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'asset/image/empty.png',
                      height: 70,
                    ),
                    const SizedBox(height: 5),
                    const Text('Your cart is empty'),
                    const Text('Try adding something to cart.'),
                  ],
                ),
              ),
            ],
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Cart'),
            ),
            body: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final cartItem = cart[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                  ),
                  title: Text(
                    cartItem['title'].toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text('Size: ${cartItem['size']}'),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Delete item',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                content: const Text(
                                  'Are you sure you want to delete this item?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<CartProvider>()
                                          .removeProduct(cartItem);
                                      // Provider.of<CartProvider>(context,
                                      //         listen: false)
                                      //     .removeProduct(cartItem); . . . same as above.
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                );
              },
            ),
          );
  }
}
