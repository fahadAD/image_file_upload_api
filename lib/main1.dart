 import 'dart:io';
import 'package:api_imagepicker/repo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  Future<void> getImage() async {
   image=await _picker.pickImage(source: ImageSource.gallery);
   setState(() {});
  }

  Future<void> getCamera() async {
    image=await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  String name = '';
  String code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Column(
        children: [


          TextFormField(
            decoration: InputDecoration(labelText: 'Product Name'),
            onChanged: (value) {
              name = value;
            },
          ),

          SizedBox(height: 10),
          // TextFormField(
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Name cannot be empty';
          //     } else if (value.length < 3) {
          //       return 'Please input at least 3 character';
          //     }
          //     return null;
          //   },
          //   decoration: InputDecoration(labelText: 'Product Code'),
          //   onChanged: (value) {
          //     code = value;
          //   },
          // ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Product Code'),
            onChanged: (value) {
              code = value;
            },
          ),
            Text(
            'Product Image',
          ),
            SizedBox(height: 10),

    Stack(
     alignment: Alignment.bottomRight,
      children: [
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            shape: BoxShape.circle,

            border: Border.all(color: Colors.black),
            image: image==null?
            DecorationImage(image: NetworkImage("https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?cs=srgb&dl=pexels-mali-maeder-102104.jpg&fm=jpg"))
                :
            DecorationImage(image: FileImage(File(image!.path)), fit: BoxFit.cover)),
      ),
      InkWell(
          onTap: () {
            setState(() {
              showDialog(context: context, builder: (context) {
                return   AlertDialog(
                  title: Text("Choose one"),
                  content: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: () {
                      setState(() {
                        getImage();
                      });
                      }, icon: Icon(Icons.photo_camera_back_outlined)),
                      IconButton(onPressed: () {
                          setState(() {
                            getCamera();
                          });
                      }, icon: Icon(Icons.camera)),
                    ],
                  ),
                );
              },);
            });
          },
          child: Icon(Icons.add_box))
    ],),

          SizedBox(height: 10),
          ElevatedButton(onPressed: () async {
            await addProduct(imageFile: File(image!.path), name: name, code: code);
          }, child: Text("upload"))
        ],
      ),
    );
  }
}
