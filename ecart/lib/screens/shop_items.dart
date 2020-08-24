import 'package:ecart/bloc/cart_items_bloc.dart';
import 'package:flutter/material.dart';

class ShopItems extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: Text('E-Cart'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/checkout'),
          )
        ],
      ),
      body: ShopItemsWidget(),
    );
  }
}

class ShopItemsWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: bloc.allItems,
      stream: bloc.getStream,
      builder: (context, snapshot) {
        return snapshot.data["shop items"].length > 0
            ? shopItemsListBuilder(snapshot)
            : Center(child: Text("All items in shop have been taken"));
      },
    );
  }
}

Widget shopItemsListBuilder(snapshot) {
  return ListView.builder(
    itemCount: snapshot.data["shop items"].length,
    itemBuilder: (BuildContext context, i) {
      final shopList = snapshot.data["shop items"];
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
              shopList[i]['name'],
              style: TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              "\$${shopList[i]['price']}",
              style: TextStyle(color: Colors.indigo[800], fontWeight: FontWeight.w400),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.add_shopping_cart,
                color: Colors.indigo[900],
              ),
              onPressed: () {
                bloc.addToCart(shopList[i]);
              },
            ),
            onTap: () {},
          ));
    },
  );
}
