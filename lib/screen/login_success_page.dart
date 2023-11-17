import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_db_flutter/model/user_model.dart';
import 'package:test_db_flutter/screen/join_page.dart';
import 'package:dio/dio.dart';
import 'package:test_db_flutter/screen/login_page.dart';
import 'package:test_db_flutter/screen/member_update_page.dart';

final dio = Dio();
final storage = FlutterSecureStorage();

class LoginSuccessPage extends StatelessWidget {
  const LoginSuccessPage({super.key, required this.users});


  final UserModel users;

  void logout(context) async {
    await storage.delete(key: 'login');
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) =>ExLoginPage()), (route) => false);

  }

  void showPopup(context, id) {
    showDialog(context: context, builder: (context){
      return Dialog(

        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 180,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            children: [
              const SizedBox(height: 32,),

              Text(
                '정말 회원탈퇴를 진행 하시겠습니까?',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),

              SizedBox(height: 40,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(onPressed: () async {
                      String result = await deleteMember(id, context);
                      if(result == 'success'){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('회원탈퇴가 완료되었습니다.'))
                        );

                        logout(context);
                        // await storage.delete(key: 'login');
                        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => ExLoginPage()), (route) => false);

                      }
                    }, icon: Icon(Icons.close), label: Text('회원 탈퇴 하기'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey)),
                    SizedBox(width: 10,),
                    ElevatedButton.icon(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close), label: Text('아니오')),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('${users.memberName} 님 환영합니다.'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        onPressed: () {
                          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MemberUpdatePage()), (route) => false);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => MemberUpdatePage(users:  users,)));

                        },
                        child: Text('회원 수정하기')),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                        onPressed: () {
                          showPopup(context, users.memberId);
                        },
                        child: Text('회원 탈퇴하기'))
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  color: Colors.grey[200],
                  width: double.infinity,
                  height: 2,
                ),
                SizedBox(
                  height: 40,
                ),
                TextButton(onPressed: (){
                    logout(context);
                }, child: Text('로그아웃하기'))

              ],
            ),
          ),
        ),
      ),
    );
  }
}





  Future<String> deleteMember(id, context) async{

    String url = 'http://172.30.1.46:8080/member/deleteMember';
    Response res = await dio.get(
        url,
        queryParameters: {'id' :id,

        }
    );

    print(res.realUri);
    if(res.statusCode ==200){
      print(res);


    }
    return res.toString();

  }