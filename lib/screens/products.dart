import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vico_grocery_store/services/firebaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vico_grocery_store/services/CartCounterBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Products extends StatefulWidget {
  const Products({super.key});
  @override
  State<Products> createState() => _productsState();
}

class _productsState extends State<Products> {
  String? firebaseUID;

  void initState() {
    super.initState();

    setState(() {
      firebaseUID = FirebaseAuth.instance.currentUser!.uid.toString();
    });
  }

  void showAddToCartDialog(
    String firebaseUID,
    String productImageUrl,
    String productName,
    String productId,
    String price,
    String soldByItem,
    String categoryId,
  ) {
    showDialog(
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setState) {
            return BlocProvider.value(
              value: CartCounterBloc(),
              child: BlocBuilder<CartCounterBloc, CounterState>(
                builder: (context, state) {
                  return AlertDialog(
                    title: Text(productName),
                    content: Container(
                      height: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            productImageUrl,
                            height: 175,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 25),
                          Text("Sold by: ${soldByItem}"),
                          Text(
                            "PHP ${price}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Total Price: ${state.quantity * double.parse(price)}",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.read<CartCounterBloc>().add(
                                    Increment(),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black45),
                                  ),
                                  child: Icon(Icons.add),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                padding: const EdgeInsets.only(
                                  top: 11,
                                  bottom: 11,
                                  left: 20,
                                  right: 20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black45),
                                ),
                                child: Text("${state.quantity}"),
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  context.read<CartCounterBloc>().add(
                                    Decrement(),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 19,
                                    right: 10,
                                    left: 10,
                                    top: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black45),
                                  ),
                                  child: Icon(Icons.minimize),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Provider.of<FirebaseServices>(
                                context,
                                listen: false,
                              ).addToCart(
                                firebaseUID,
                                productId,
                                price,
                                state.quantity.toString(),
                                soldByItem,
                                categoryId,
                              );
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(top: 15),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blueAccent,
                              ),
                              child: Text(
                                "Add To Cart",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  } // showAddToCartDialog

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text("Our Products"),
            Text(
              "View available products in this Store",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 20,
                    offset: Offset(4, 4),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Branch",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("BGC - Taguig"),

                          Text(
                            "32nd Street, Bonifacio Global City",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),

                      SizedBox(width: 15),
                      Container(
                        child: Icon(Icons.arrow_forward_ios_outlined, size: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 250,
              padding: const EdgeInsets.all(15),
              child: StreamBuilder(
                stream:
                    Provider.of<FirebaseServices>(
                      context,
                      listen: false,
                    ).getProductsData().asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Products cannot retrieve this time\nTry again later or reopen application",
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      mainAxisExtent: 405,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 0.55,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final dataContent = snapshot.data;
                      String productId = dataContent![index].product_id;

                      String productName = dataContent![index].product_name;
                      String productPrice = dataContent![index].price;
                      //String currentStock = dataContent![index].current_stock;
                      String categoryId = dataContent![index].category_id;
                      String soldByQty = dataContent![index].sold_by_quantity;
                      String imageUrl = dataContent![index].url_image;

                      return Container(
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.all(15),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8.8,
                              spreadRadius: 10,
                              offset: Offset(4, 4),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              imageUrl,
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 12),
                            Text(
                              productName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "PHP " + productPrice,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "Sold by " + soldByQty,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              categoryId,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showAddToCartDialog(
                                      firebaseUID ?? "",
                                      imageUrl,
                                      productName,
                                      productId,
                                      productPrice,
                                      soldByQty,
                                      categoryId,
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black26),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.shopping_cart, size: 15),
                                        SizedBox(width: 4.5),
                                        Text("Add to Cart"),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.5),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    right: 20,
                                    left: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Checkout",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(width: 4.5),
                                      Icon(
                                        Icons.arrow_right_alt_outlined,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
