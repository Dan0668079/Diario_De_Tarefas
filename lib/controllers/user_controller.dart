import 'package:teste/src/src.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//////signed - usuário
//////unsigned - usuário deslogado
//////loading - usuário carregando
enum AuthState { signed, unsigned, loading }

class UserController extends ChangeNotifier {
  // o estado da autenticação começa carregando
  AuthState authState = AuthState.loading;
  late UserModel model;

  //criando uma variavel _auth que so pode ser vista localmente e instanciando o FirebaseAuth.instance
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  //toda vez que chamat o get ele retorna o usuário atual se não estiver logado ele será nulo
  User? get user => _auth.currentUser;

  UserController() {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        final data = await _db.collection('usuarios').doc(user.uid).get();
        model = UserModel.fromMap(data.data()!);

        authState = AuthState.signed;
      } else {
        authState = AuthState.unsigned;
      }
      //notifica a auteração a quem estiver escutando
      notifyListeners();
    });
  }
  //funcao referente ao logar
  Future<void> login(String email, String senha) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }

  //função referente ao logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  //função referente a comunicação da tela de cadastro com firebase
  Future<void> signup(
    String email,
    String senha,
    UserModel payload,
  ) async {
    //criando as credenciais do usuario
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
    // depois da credêncial criada é gerado uma uid de identificação. Estamos armazenando ela
    final uid = credentials.user?.uid;
    //estamos armazenando em data o payload que recebe um mapa
    final data = payload.toMap();
    //estamos add a uid no campo da key
    data['key'] = uid;
    //estamos armazenando os valores na coleção firebase
    final doc = _db.collection('usuarios').doc(uid);
    await doc.set(data);
  }

//função referente ao envio de email para senha
  Future<void> updateSenha(String email, context) async {
    await _auth.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email enviado com sucesso!'),
      ),
    );
  }

  //--------------------------------------------------------
  //   Future<void> delete() async {
  //   await FirebaseFirestore.instance
  //       .collection('usuarios')
  //       .doc(user!.uid)
  //       .delete();

  //   await user!.delete();
  // }

// Future<void> updateUser(String email, Map<String, dynamic> newUser) async {
//     await user!.updateEmail(email);
//     await FirebaseFirestore.instance
//         .collection('usuarios')
//         .doc(user!.uid)
//         .update(newUser);
//   }

}
