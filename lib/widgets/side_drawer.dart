import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.maxFinite,
        height: 200,
      color: Theme.of(context).primaryColor,
      child: Text(
        'Welcome',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
      ),
    ),
        _buildListItem('Home', Icons.home),
        Divider(color: Colors.green, height: 20, thickness: 3,),

        _buildListItem('Shop', Icons.shop),
        Divider(color: Colors.black, height: 20, thickness: 3,),
        
        _buildListItem('Logout', Icons.exit_to_app),
      ],
    );
  }

  Widget _buildListItem(String name, IconData icon){
    return
      ListTile(leading: Icon(icon,color: Colors.black, size: 30,),
        title: Text(name, style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
        ),),);

  }
}
