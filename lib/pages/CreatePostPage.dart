import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iorg_flutter/main.dart';
import 'package:uuid/uuid.dart';
import 'HomePage.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class CreatePostPage extends StatefulWidget {
  CreatePostPage({Key key}) : super(key: key);
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage>
    with AutomaticKeepAliveClientMixin<CreatePostPage> {
  final GlobalKey<ScaffoldState> _createPageGlobalKey =
      GlobalKey<ScaffoldState>();
  final GlobalKey<FormBuilderState> _createFormBuilderGlobalKey =
      GlobalKey<FormBuilderState>();
  bool get wantKeepAlive => true;
  final ValueChanged _onChanged = (val) => print(val);
  final _nameController = TextEditingController(
      text: 'ENTRY_${DateTime.now().microsecondsSinceEpoch}');
  final _detailsController = TextEditingController(
      text:
          'This entry was created on ${DateTime.now().microsecondsSinceEpoch}');
  var _priority = 1.0;
  // double _progressBarValue = 0;
  String postId = Uuid().v4();
  User _currentUserAuth;
  bool _uploading;
  Map<String, dynamic> mapData;

  @override
  void initState() {
    super.initState();
    _uploading = false;
    _currentUserAuth = FirebaseAuth.instance.currentUser;
    print("Create-init");
  }

  Stream<TaskSnapshot> uploadImage(Uri imgFile) {
    File _tempFile = new File.fromUri(imgFile);
    UploadTask storageUploadTask =
        storageReference.child("post_$postId.jpg").putFile(_tempFile);
    return storageUploadTask.snapshotEvents;
  }

  double _bytesTransferredInPercentage(var snapshot) {
    return snapshot.bytesTransferred.toDouble() /
        snapshot.totalByteCount.toDouble() *
        100;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("Create-build");
    return _uploading
        ? _buildUploadingScreen()
        : Scaffold(
            key: _createPageGlobalKey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text("CREATE ENTRY"),
              backgroundColor: Theme.of(context).primaryColor,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.restore,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _createFormBuilderGlobalKey.currentState.reset();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (_createFormBuilderGlobalKey.currentState
                        .saveAndValidate())
                      mapData = new Map<String, dynamic>.from(
                          _createFormBuilderGlobalKey.currentState.value);

                    setState(() {
                      _uploading = true;
                    });
                    print("Check clicked");
                  },
                ),
              ],
            ),
            body: buildForm());
  }

  _buildUploadingScreen() {
    return StreamBuilder(
      stream: uploadImage(mapData["image"][0].uri),
      builder: (context, AsyncSnapshot<TaskSnapshot> asyncSnapshot) {
        double _uploadProgress = 0.0;
        String _uploadDetails = "Uploading, Please wait...";
        // Widget subtitle = Text("");
        if (asyncSnapshot.hasError) {
          return buildUploadErrorHandler(asyncSnapshot.error);
        }
        if (asyncSnapshot.hasData) {
          final TaskSnapshot event = asyncSnapshot.data;
          final snapshot = event.state;
          switch (event.state) {
            case TaskState.running:
              {
                // setState(() {
                //   _progressBarValue = _bytesTransferred(snapshot);
                // });
                // _progressBarValue = _bytesTransferred(snapshot);
                // _uploadProgress = _bytesTransferredInPercentage(snapshot);
                // _uploadDetails = "Upload Progress : $_uploadProgress %";
                // print("uploadProgress::::$_uploadProgress");
              }
              break;
            case TaskState.error:
              print("uploadTaskFailed");
              break;
            case TaskState.success:
              {
                if (mapData.isEmpty) {
                  print(" mapDAta :: null");
                } else {
                  event.ref.getDownloadURL().then((downloadURL) {
                    print('picUrl == $downloadURL');
                    postReference
                        .doc(postId)
                        .set({
                          "postId": postId,
                          "ownerId": _currentUserAuth.uid,
                          "timestamp": DateTime.now(),
                          "image": downloadURL,
                          "postName": mapData['name'],
                          "deadline": mapData['deadline'],
                          "priority": mapData['priority'],
                          "details": mapData['details'],
                          'archive': false,
                        })
                        .then((value) => print("Post Added"))
                        .catchError(
                            (error) => print("Failed to add post: $error"));
                  });
                  print("Cloud Save executed");
                  return HomePage(_currentUserAuth);
                }
              }
              break;
            default:
          }
        } else {
          _uploadDetails = "Starting Upload Process";
          // subtitle = Text('Starting...');
        }
        return Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color.fromARGB(200, 255, 255, 255),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  // value: _progressBarValue,
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  backgroundColor: Colors.grey,
                  strokeWidth: 3.0,
                ),
                Text("   "),
                Flexible(
                  child: Text(
                    _uploadDetails,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  buildForm() {
    return ListView(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      children: <Widget>[
        FormBuilder(
          key: _createFormBuilderGlobalKey,
          // readOnly: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FormBuilderImagePicker(
                name: 'image',
                maxHeight: MediaQuery.of(context).size.width * 0.90,
                maxWidth: MediaQuery.of(context).size.width * 0.90,
                imageQuality: 10,
                // labelText: 'Pick a document:',
                // defaultImage: AssetImage('images/image-placeholder.jpg'
                //     // 'https://cohenwoodworking.com/wp-content/uploads/2016/09/image-placeholder-500x500.jpg',
                //     ),
                maxImages: 1,
                // validator: [
                //   FormBuilderValidators.required(),
                //   (images) {
                //     if (images.length <= 0) {
                //       return 'Image required.';
                //     }
                //     return null;
                //   }
                // ],
              ),
              SizedBox(height: 15),
              FormBuilderTextField(
                name: 'name',
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name:',
                ),
                onChanged: (val) {
                  // print(val);
                },
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15),
              FormBuilderDateTimePicker(
                name: 'deadline',
                onChanged: _onChanged,
                inputType: InputType.both,
                decoration: const InputDecoration(
                  labelText: 'Deadline:',
                ),
                validator: (val) => null,
                initialTime: TimeOfDay.now(),
                initialValue: DateTime.now(),
              ),
              SizedBox(height: 15),
              FormBuilderSlider(
                name: 'priority',
                decoration: const InputDecoration(
                  labelText: 'Set Priority:',
                ),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    _priority = value;
                  });
                },
                min: 1.0,
                max: 3.0,
                initialValue: _priority,
                divisions: 2,
                activeColor: returnPriorityColor(_priority),
                inactiveColor: Colors.pink[100],
                displayValues: DisplayValues.current,
              ),
              SizedBox(height: 15),
              FormBuilderTextField(
                name: 'details',
                // autovalidate: true,
                controller: _detailsController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Details',
                ),
                onChanged: (val) {
                  print(val);
                },
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildUploadErrorHandler(Error err) {
    return Scaffold(
      body: Center(
        child: Expanded(
            child: Text(
          "UploadErr::::$err",
          style: TextStyle(fontSize: 50, color: Colors.white),
        )),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    super.dispose();
  }
}
