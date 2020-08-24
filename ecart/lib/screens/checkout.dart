import 'package:ecart/bloc/cart_items_bloc.dart';
import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.indigo[900], title: Text('Checkout')),
      body: StreamBuilder(
        stream: bloc.getStream,
        initialData: bloc.allItems,
        builder: (context, snapshot) {
          return snapshot.data['cart items'].length > 0
              ? Column(
                  children: <Widget>[
                    Expanded(child: checkoutListBuilder(snapshot)),
                    RaisedButton(
                      onPressed: () {},
                      child: Text(
                        "Checkout",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.indigo[900],
                    ),
                    SizedBox(height: 40)
                  ],
                )
              : Center(child: Text("You haven't added any item for checkout"));
        },
      ),
    );
  }
}

Widget checkoutListBuilder(snapshot) {
  return ListView.builder(
    itemCount: snapshot.data["cart items"].length,
    itemBuilder: (BuildContext context, i) {
      final cartList = snapshot.data["cart items"];

      return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.indigo[900], blurRadius: 2)],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          child: ListTile(
            title: Text(
              cartList[i]['name'],
              style: TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              "\$${cartList[i]['price']}",
              style: TextStyle(color: Colors.indigo[800], fontWeight: FontWeight.w400),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.remove_shopping_cart,
                color: Colors.indigo[900],
              ),
              onPressed: () {
                bloc.removeFromCart(cartList[i]);
              },
            ),
            onTap: () {},
          ));
    },
  );
}
