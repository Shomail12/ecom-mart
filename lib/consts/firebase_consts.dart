import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseAuth auth=FirebaseAuth.instance;
FirebaseFirestore firestore=FirebaseFirestore.instance;
User? currentUser=auth.currentUser;

const usersCollection="user";
const cartCollection="Cart Collection";
const chatCollection="Chat Collection";
const messageCollection="Messages Collection";
const productsCollection="products";
const ordersCollection="Orders";