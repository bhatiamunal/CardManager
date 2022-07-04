import 'package:flutter/material.dart';
import '../libDrt/sql_helper.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;
  final card_number = TextEditingController();
  final card_owner = TextEditingController();
  final card_expiration_date = TextEditingController();
  final card_payment_system = TextEditingController();
  final gen_title = TextEditingController();
  final gen_currency = TextEditingController();
  final gen_credit_limit = TextEditingController();
  final pvt_pin = TextEditingController();
  final pvt_cvc = TextEditingController();
  final login_userName = TextEditingController();
  final login_password = TextEditingController();
  final login_secret = TextEditingController();

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading=false;
    });
  }

  Widget _showForm() {
    late var  args = ModalRoute.of(context)!.settings.arguments  ;
    var ids = null;

  print(args);

    if (args != null) {
      late Map  args = ModalRoute.of(context)!.settings.arguments as Map  ;
      print(_journals);
      ids= args['id'] ;
      print("------------------------------------------------------------------");
      print(ids);
      print("------------------------------------------------------------------");
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == ids);

      card_number.text = existingJournal['card_number'];
      card_owner.text = existingJournal['card_owner'];
      card_expiration_date.text = existingJournal['card_expiration_date'];
      card_payment_system.text = existingJournal['card_payment_system'];

      gen_title.text = existingJournal['gen_title'];
      gen_currency.text = existingJournal['gen_currency'];
      gen_credit_limit.text = existingJournal['gen_credit_limit'];

      pvt_pin.text = existingJournal['pvt_pin'];
      pvt_cvc.text = existingJournal['pvt_cvc'];

      login_userName.text = existingJournal['login_userName'];
      login_password.text = existingJournal['login_password'];
      login_secret.text = existingJournal['login_secret'];
    }

    return Center(
        child: SingleChildScrollView(
            child: Card(
              child: Padding(padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        controller: card_number,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: 'Card Number',
                            labelText: 'Card Number',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: gen_title,

                        decoration: InputDecoration(hintText: 'Title',
                            labelText: 'Title',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: card_owner,
                        decoration:  InputDecoration(hintText: 'Card Owner',
                            labelText: 'Card Owner',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: card_expiration_date,
                        decoration:
                             InputDecoration(hintText: 'Card Expire Date ',
                                 labelText: 'Card Expire Date',
                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                             ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: card_payment_system,
                        decoration:
                             InputDecoration(hintText: 'Card Payement System',
                                labelText: 'Card Payement System ',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: gen_currency,
                        decoration:  InputDecoration(hintText: 'Currency',
                            labelText: 'Currency ',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: gen_credit_limit,
                        decoration:  InputDecoration(hintText: 'Credit Limit',
                            labelText: 'Credit Limit ',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: pvt_pin,
                        decoration:  InputDecoration(hintText: 'Pin',
                            labelText: 'Pin ',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: pvt_cvc,
                        decoration:  InputDecoration(hintText: 'CVC',
                            labelText: 'CVC',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: login_userName,
                        decoration:  InputDecoration(hintText: 'Login',
                            labelText: 'Login ',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: login_password,
                        decoration:  InputDecoration(hintText: 'Password',
                            labelText: 'Password ',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: login_secret,
                        decoration:  InputDecoration(hintText: 'Secret',
                            labelText: 'Secret ',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // Save new journal
                          if (ids == null) {
                            await _addItem();
                          }

                          if (ids != null) {
                            await _updateItem(ids);
                          }

                          // Clear the text fields
                          card_number.text = '';
                          card_owner.text = '';
                          card_expiration_date.text = '';
                          card_payment_system.text = '';

                          gen_title.text = '';
                          gen_currency.text = '';
                          gen_credit_limit.text = '';

                          pvt_pin.text = '';
                          pvt_cvc.text = '';

                          login_userName.text = '';
                          login_password.text = '';
                          login_secret.text = '';
                        },
                        child: Text(ids == null ? 'Create New' : 'Update'),
                      )
            ],
          )),
      elevation: 8,
      shadowColor: Colors.black,
      margin: EdgeInsets.all(5),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black, width: 1)),
    )));
  }
  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }
  // Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        card_number.text,
        card_owner.text,
        card_expiration_date.text,
        card_payment_system.text,
        gen_title.text,
        gen_currency.text,
        gen_credit_limit.text,
        pvt_pin.text,
        pvt_cvc.text,
        login_userName.text,
        login_password.text,
        login_secret.text);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully Added'),
        ));
        _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {

    await SQLHelper.updateItem(
        id,
        card_number.text,
        card_owner.text,
        card_expiration_date.text,
        card_payment_system.text,
        gen_title.text,
        gen_currency.text,
        gen_credit_limit.text,
        pvt_pin.text,
        pvt_cvc.text,
        login_userName.text,
        login_password.text,
        login_secret.text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully Updated'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context)   {

    // final data = args['id'].toString();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Add Card'),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isLoading
          ?const Center(
        child: CircularProgressIndicator(),
      )
          :  _showForm()
    );
  }
}
