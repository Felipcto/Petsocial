import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Cadastro(),
    );
  }
}

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String cpfCnpj = '';
  String email = '';
  String password = '';
  String phone = '';
  bool isCpfSelected = true;

  final cpfCnpjController = MaskedTextController(mask: '000.000.000-00');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome';
                    }
                    return null;
                  },
                  onSaved: (value) => name = value ?? '',
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: true,
                      groupValue: isCpfSelected,
                      onChanged: (value) {
                        setState(() {
                          isCpfSelected = value!;
                          _updateMask();
                        });
                      },
                    ),
                    Text('CPF'),
                    Radio(
                      value: false,
                      groupValue: isCpfSelected,
                      onChanged: (value) {
                        setState(() {
                          isCpfSelected = value!;
                          _updateMask();
                        });
                      },
                    ),
                    Text('CNPJ'),
                  ],
                ),
                TextFormField(
                  controller: cpfCnpjController,
                  decoration: InputDecoration(
                    labelText: isCpfSelected ? 'CPF' : 'CNPJ',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    String cleanValue = value?.replaceAll(RegExp(r'\D'), '') ?? '';
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu ${isCpfSelected ? 'CPF' : 'CNPJ'}';
                    }
                    if (isCpfSelected) {
                      if (!_validateCpf(cleanValue)) {
                        return 'Por favor, insira um CPF válido';
                      }
                    } else {
                      if (!_validateCnpj(cleanValue)) {
                        return 'Por favor, insira um CNPJ válido';
                      }
                    }
                    return null;
                  },
                  onSaved: (value) => cpfCnpj = value ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu e-mail';
                    }
                    return null;
                  },
                  onSaved: (value) => email = value ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    return null;
                  },
                  onSaved: (value) => password = value ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Telefone'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu telefone';
                    }
                    return null;
                  },
                  onSaved: (value) => phone = value ?? '',
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateMask() {
    if (isCpfSelected) {
      cpfCnpjController.updateMask('000.000.000-00');
    } else {
      cpfCnpjController.updateMask('00.000.000/0000-00');
    }
  }

  bool _validateCpf(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'\D'), '');
    if (cpf.length != 11) return false;

    List<int> numbers = cpf.codeUnits.map((e) => e - 48).toList();

    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += numbers[i] * (10 - i);
    }

    int verifyingDigit = sum % 11;
    verifyingDigit = verifyingDigit < 2 ? 0 : 11 - verifyingDigit;

    if (numbers[9] != verifyingDigit) return false;

    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += numbers[i] * (11 - i);
    }

    verifyingDigit = sum % 11;
    verifyingDigit = verifyingDigit < 2 ? 0 : 11 - verifyingDigit;

    if (numbers[10] != verifyingDigit) return false;

    return true;
  }

  bool _validateCnpj(String cnpj) {
    cnpj = cnpj.replaceAll(RegExp(r'\D'), '');
    if (cnpj.length != 14) return false;

    List<int> numbers = cnpj.codeUnits.map((e) => e - 48).toList();

    int sum = 0;
    for (int i = 0; i < 12; i++) {
      sum += numbers[i] * (6 - (i % 4));
    }

    int verifyingDigit = sum % 11;
    verifyingDigit = verifyingDigit < 2 ? 0 : 11 - verifyingDigit;

    if (numbers[12] != verifyingDigit) return false;

    sum = 0;
    for (int i = 0; i < 13; i++) {
      sum += numbers[i] * (6 - (i % 4));
    }

    verifyingDigit = sum % 11;
    verifyingDigit = verifyingDigit < 2 ? 0 : 11 - verifyingDigit;

    if (numbers[13] != verifyingDigit) return false;

    return true;
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      print('Nome: $name\nCPF/CNPJ: $cpfCnpj\nE-mail: $email\nSenha: $password\nTelefone: $phone');

      // Exibir um aviso de sucesso usando um SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$name Bem-Vindo, seu cadastro foi efetuado com sucesso '),
        ),
      );
    }
  }
}
