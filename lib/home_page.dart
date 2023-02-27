
import 'package:flutter/material.dart';
import 'package:hive_db_example/model/note.dart';
import 'package:hive_db_example/note_service.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _notesService = NotesService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantitiController = TextEditingController();



  List<Note> noteList = [];

  @override
  void initState() {
    super.initState();


    initNotes();
  }

  Future<void> initNotes()  async {
    await _notesService.init();
    getNotes();
  }

  void getNotes() {
    noteList =_notesService.getNotes();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,


              // ElevatedButton(onPressed: (){
              //   noteList =_notesService.getNotes();
              //   setState(() {});


             child: ListView.builder(

                shrinkWrap: true,
                itemCount: noteList.length,
                  itemBuilder: (context , index){
                   return itemWidget(size , noteList[index]);
                  }),


      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
          onPressed: (){
            _showBottomForm(context , null );
          }),
    );
  }

  void _showBottomForm(BuildContext context, Note? note) async {
     showModalBottomSheet(
         context: context,
         elevation: 5,
         isScrollControlled: true,
         builder: (_) =>Container(
           padding: EdgeInsets.only(
               bottom: MediaQuery.of(context).viewInsets.bottom,  // to prevent covering testField with keyboard
             top: 15,
             left: 15,
             right: 15
           ),

           child: Column(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [

               TextField(
                 controller: _nameController,
                 decoration: const InputDecoration(hintText: "Name"),

               ),

               SizedBox(height: 10,),

               TextField(
                 controller: _quantitiController,
                 decoration: const InputDecoration(hintText: "Quantity"),
               ),

               SizedBox(height: 20,),
               
               ElevatedButton(onPressed: () async {

                 if(note == null){  // means newData
                   Note note = Note();
                   note.title = _nameController.text;
                   note.content = _quantitiController.text;
                   _notesService.addOrUpdateNote(note);
                 }else{  // means Update

                   note.title = _nameController.text;
                   note.content = _quantitiController.text;
                   _notesService.addOrUpdateNote(note);
                 }


                 getNotes();

                 //clear textFields
                 _nameController.text = "";
                 _quantitiController.text = "";

                 Navigator.of(context).pop();

               }, child: Text("Create New"))

             ],
           ),
         )

     );
  }

  Widget itemWidget(Size size, Note note) {

   return Container(
      width: size.width,
      height: 70,
      margin: EdgeInsets.all(5),
      color: Colors.red,

     child: ListTile(
       title: Text(note.title),
       subtitle: Text(note.content),
       trailing: Row(
         mainAxisSize: MainAxisSize.min,
         children: [
           IconButton(icon: Icon(Icons.edit) ,onPressed: (){

             _nameController.text = note.title;
             _quantitiController.text = note.content;
             _showBottomForm(context , note);
             // note.title = "updatedTitle";
             // _notesService.addOrUpdateNote(note);
             //
             // getNotes();

           },),
           SizedBox(width: 5,),
           IconButton(icon: Icon(Icons.delete) ,onPressed: (){
             _notesService.deleteNote(note);
             getNotes();
           },),
         ],
       ),
     ),
    );


  }




}
