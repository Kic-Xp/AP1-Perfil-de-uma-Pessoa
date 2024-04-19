import 'package:flutter/material.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Perfil de uma Pessoa",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileForm(),
    );
  }
}

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _professionController = TextEditingController();
  String? _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Uma Pessoa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua idade';
                  }
                  if (int.tryParse(value) == null) {
                    return 'A idade deve ser um valor numérico';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _professionController,
                decoration: InputDecoration(labelText: 'Profissão'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua profissão';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                value: _gender,
                hint: Text('Gênero'),
                onChanged: (value) {
                  setState(() {
                    _gender = value.toString();
                  });
                },
                items: ['Masculino', 'Feminino']
                    .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione seu gênero';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String name = _nameController.text;
                    String age = _ageController.text;
                    String profession = _professionController.text;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeMessage(
                          name: name,
                          age: age,
                          profession: profession,
                          gender: _gender!,
                        ),
                      ),
                    );
                  }
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeMessage extends StatelessWidget {
  final String name;
  final String age;
  final String profession;
  final String gender;

  WelcomeMessage({required this.name, required this.age, required this.profession, required this.gender});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Bem-vindo, $name!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Idade: $age'),
            Text('Profissão: $profession'),
            Text('Gênero: $gender'),
          ],
        ),
      ),
    );
  }
}
