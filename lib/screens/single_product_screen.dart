import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoepal/providers/product.dart';
import 'package:shoepal/providers/products.dart';
import 'package:shoepal/shared/styles.dart';
import 'package:shoepal/widget/button.dart';

class SingleProductScreen extends StatefulWidget {
  static const routeName = '/single-product';

  @override
  _SingleProductScreenState createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _newProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
    isFavorite: false,
  );
  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isEditMode = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;

      if (productId != null) {
        _newProduct = Provider.of<Products>(
          context,
          listen: false,
        ).findById(productId);
        _initValues = {
          'title': _newProduct.title,
          'description': _newProduct.description,
          'price': _newProduct.price.toStringAsFixed(0),
          // 'imageUrl': _newProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _newProduct.imageUrl;
        _isEditMode = true;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('https') &&
              !_imageUrlController.text.startsWith('http')) ||
          (!_imageUrlController.text.endsWith('png') &&
              !_imageUrlController.text.endsWith('jpg') &&
              !_imageUrlController.text.endsWith('jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    _form.currentState.save();

    print(_newProduct.id);
    print(_newProduct.title);
    print(_newProduct.price);
    print(_newProduct.description);
    print(_newProduct.imageUrl);

    if (_newProduct.id != null) {
      // edit product
      Provider.of<Products>(context, listen: false).editProduct(
        _newProduct.id,
        _newProduct,
      );
    } else {
      // Add Product
      Provider.of<Products>(context, listen: false).addProduct(_newProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditMode ? 'Edit Product' : 'Add Product'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 30,
          ),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['title'],
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: giveInputStyle('Title'),
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter a product title';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (val) => _newProduct = Product(
                    id: _newProduct.id,
                    title: val,
                    description: _newProduct.description,
                    price: _newProduct.price,
                    imageUrl: _newProduct.imageUrl,
                    isFavorite: _newProduct.isFavorite,
                  ),
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  style: Theme.of(context).textTheme.bodyText1,
                  keyboardType: TextInputType.number,
                  decoration: giveInputStyle('Price'),
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(val) == null) {
                      return 'Please enter a valid number';
                    }
                    if (double.tryParse(val) <= 1000) {
                      return 'Please enter price greater than Rp 1000';
                    }
                    return null;
                  },
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (val) => _newProduct = Product(
                    id: _newProduct.id,
                    title: _newProduct.title,
                    description: _newProduct.description,
                    price: double.parse(val),
                    imageUrl: _newProduct.imageUrl,
                  ),
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  style: Theme.of(context).textTheme.bodyText1,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: giveInputStyle('Description'),
                  focusNode: _descriptionFocusNode,
                  onSaved: (val) => _newProduct = Product(
                    id: _newProduct.id,
                    title: _newProduct.title,
                    description: val,
                    price: _newProduct.price,
                    imageUrl: _newProduct.imageUrl,
                    isFavorite: _newProduct.isFavorite,
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter your description';
                    }
                    if (val.length < 16) {
                      return 'Please enter at least 16 characters';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 16, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[200],
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Center(
                              child: Text(
                                'Enter your URL',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        keyboardType: TextInputType.url,
                        decoration: giveInputStyle('Image URL'),
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please provide an image URL';
                          }
                          if (!val.startsWith('http') &&
                              !val.startsWith('https')) {
                            return 'Please enter a valid URL';
                          }
                          if (!val.endsWith('png') &&
                              !val.endsWith('jpg') &&
                              !val.endsWith('jpeg')) {
                            return 'Provided link is not an image URL';
                          }
                          return null;
                        },
                        onSaved: (val) => _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          description: _newProduct.description,
                          price: _newProduct.price,
                          imageUrl: val,
                          isFavorite: _newProduct.isFavorite,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 90,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 30,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Button(
                    _isEditMode ? 'Save Changes' : 'Add Product',
                    _saveForm,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
