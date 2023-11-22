

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/provider/product_provider.dart';

class AttributesTabScreen extends StatefulWidget {


  @override
  State<AttributesTabScreen> createState() => _AttributesTabScreenState();
}

class _AttributesTabScreenState extends State<AttributesTabScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _sizeController = TextEditingController();
  bool _entered = false;

  List<String> _sizeList = [];

  bool _isSave = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider = Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [

          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Container(
                  width: 400,
                  child: TextFormField(
                    controller: _sizeController,
                    onChanged: (value) {
                      setState(() {
                        _entered = true;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Number of available rooms or bedspace',
                    ),
                  ),
                ),
              ),

              _entered == true?
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue.shade300),
                onPressed: () {
                  setState(() {
                    _sizeList.add(_sizeController.text);
                    _sizeController.clear();
                  });
                  print(_sizeList);
                },
                child: Text (
                  'Add',
                  ),
                )
                :Text(''),
            ],
          ),

          if (_sizeList.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _sizeList.length,
                itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _sizeList.removeAt(index);
                        _productProvider.getFormData(sizeList: _sizeList);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_sizeList[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              )),
            ),
          ),
          if (_sizeList.isNotEmpty)
          ElevatedButton(
            onPressed: () {
              _productProvider.getFormData(sizeList: _sizeList);

              setState(() {
                _isSave = true;
              });
            },
            child: Text(
              _isSave?
              'Saved':'save',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}