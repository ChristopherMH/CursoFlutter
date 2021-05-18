import 'package:flutter/material.dart';


class BasicDesignScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(image: AssetImage('assets/landscape.jpg'),),
          Title(),
          ButtonSection(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10, ),
            child: Text("Who Built the Moon? was a work in progress since Chasing Yesterday was being recorded, Noel has stated in interviews that this album was being recorded not only during those sessions but also during the Chasing Yesterday World Tour. The album was announced on 25 September 2017 through Gallagher's social media accounts, with the upcoming 2018 UK and Ireland tour. In an interview with Colombian DJ Alejandro Marín, Gallagher revealed that the woman on the album's cover is his wife Sara MacDonald. This is the final album to feature the drummer Jeremy Stacey, who was departed from the band in 2016 during the recording to supporting the tour of King Crimson. He was temporarily replaced by Emre Ramazanoglu to continue the recording.")
            )
        ],
      )
   );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Who Built the Moon?', style: TextStyle(fontWeight: FontWeight.bold),),
              Text("Noel Gallagher's High Flying Birds", style: TextStyle(color: Colors.black45),)
            ],
          ),
          Expanded(child: Container()),
          Icon(Icons.star, color: Colors.red),
          Text('41')
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(icon: Icons.call, text: 'Call',),
          CustomButton(icon: Icons.map_sharp, text: 'Route',),
          CustomButton(icon: Icons.share,text: 'Share',),
        ],
        ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  
  const CustomButton({
    Key? key,
    required this.icon, 
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(this.icon, color: Colors.blue, size: 30,),
        Text(this.text, style: TextStyle(color: Colors.blue),)
      ],
    );
  }
}