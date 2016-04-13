
//  Modelling_Based_on_LeapMotion.pde
//  Modelling System Based on LeapMiton
//
//  Created by yorksero831 on 16/4/13.
//  Copyright © 2016年 SakaiLab-York. All rights reserved.
//

import de.voidplus.leapmotion.*;
LeapMotion leap;


String MODE = "OBJECT MODE";
float x = 0;
float y = 0;
float z = 0;
Commands cmd = new Commands();
/////////////////////test////////////
YObject testobj;
YObject testobj1;
/////////////////////////////////////
Selector selector = new Selector();
ArrayList<YObject> List_of_Objects = new ArrayList<YObject>();
PGraphics FLayer;
PGraphics BLayer;
void setup()
{

  size(600, 600, P3D);
  frameRate(30);

  leap = new LeapMotion(this).withGestures();
 
  testobj1 = cmd.Cube(100, 100, 100, 5, 5, 5);  //////////Create 5X5X5 cube named testobj1
                 
  List_of_Objects.add(testobj1);
  
  selector.Add(testobj1);                            //////Put testobj into selector
 
  FLayer = createGraphics(width, height, P3D);
  BLayer = createGraphics(width, height, P3D);
  //////voce system init///////
  String url2 = "/Users/sakailab_macbook_B/Downloads/Modelling_Based_on_LeapMotion/";
  voce.SpeechInterface.init("/Users/sakailab_macbook_B/Downloads/Modelling_Based_on_LeapMotion/libraries/voce-0.9.1/", true, true, url2, "ss");
}

PVector hand_position_last = new PVector();
float dy = 0;
float dx = 0;
float dz = 0;

///////////////////////sound Text invitital/////////////
String getStringStore = "OBJECT MODE";
void draw()
{
  background(200, 200, 200);
  BLayer.beginDraw();
  BLayer.camera(0, 0, height/2/ tan(PI*30.0 / 180.0), 0, 0, 0, 0, 1, 0);
  BLayer.background(0, 0, 0, 0);
  //////////////////soundText//////////////////
  String getString;  
  //BLayer.stroke(0); 
  BLayer.textSize(25);  
  BLayer.fill(0);
  BLayer.text(MODE, -75, -250);
  BLayer.fill(255);
  ////////////////////////////////////////////
  if (leap.countHands()>0)
  {
    Hand hand = leap.getRightHand();
    int countHand = leap.countHands();
    //int hid = hand.getId();

    if (countHand>1)
    {
      //////////////////////////sound reglize//////////  
      getString = voce.SpeechInterface.popRecognizedString();
      if(getString != "")
      {
        println(getString);
      }
      if (getString.equals("point"))
      {
        MODE = "POINT MODE";
      }
      if (getString.equals("o"))
      {
        MODE = "OBJECT MODE";
      }
      if (getString.equals("select"))
      {
        cmd.Select_it(MODE, selector, List_of_Objects, hand_position_last.x - 0.5*height, hand_position_last.y -0.5*width, -(hand_position_last.z -15)*10);
      }
      ////////////////////////////////////////////////////////
    }
    PVector hand_position    = hand.getPosition();
    dy = hand_position_last.y - hand_position.y;
    dx = hand_position_last.x - hand_position.x;
    dz = hand_position_last.z - hand_position.z;
    
    PVector zo = hand_position.cross(hand_position_last);
    zo.y = 0;
    zo.z *=2;
    zo.normalize();
    //YVector zop = new YVector(-zo.z, -zo.x, 0);  //-zo.z  ,  , zo.x

    //float angle = sqrt(dx*dx+dy*dy+dz*dz*1)*PI/240;
    /////////////////////////////Gesture code///////////////////////////////////////////////
    if (hand.hasFingers())
    {
      ArrayList<Finger> fingers = hand.getFingers();
      PVector finger1_position;
      PVector finger2_position;
      float   f1_f2_distance;
      if (fingers.size()>=2)
      {
        Finger f1 = fingers.get(0);
        finger1_position = f1.getPosition();
        
        Finger f2 = fingers.get(1);
        finger2_position = f2.getPosition();  
        
        f1_f2_distance = dist(finger1_position.x,finger1_position.y,finger1_position.z,finger2_position.x,finger2_position.y,finger2_position.z);
        if(f1_f2_distance<=13)
        {
          cmd.Select_it(MODE, selector, List_of_Objects, hand_position_last.x - 0.5*height, hand_position_last.y -0.5*width, -(hand_position_last.z -15)*10);
        }

      }
      if (fingers.size()==1)
      {
        cmd.Move(MODE, selector, -dx, -dy, dz*10);
      }
      if (fingers.size()==2)
      {
        YVector zop_x =  new YVector(1, 0, 0);
        YVector zop_y =  new YVector(0, 1, 0);
        YVector zop_z =  new YVector(0, 0, 1); 
        float angle_x = dx*PI/240;
        float angle_y = dy*PI/240; 
        float angle_z = dz*PI/240;  
        cmd.Rotate_it(selector, zop_x, -angle_y);
        cmd.Rotate_it(selector, zop_y, angle_x);
        cmd.Rotate_it(selector, zop_z, angle_z);
      }
    }
    /////////////////////////////testCode//////////////////////////////////////////////////    

    if (keyPressed) 
    {
      if (key == '1') 
      {
        MODE = "OBJECT MODE";
        println(MODE);
      }
      if (key == '2') 
      {
        MODE = "POINT MODE";
        println(MODE);
      }
      if (key == 'm' || key == 'M') 
      {
        cmd.Move(MODE, selector, -dx, -dy, dz*10);
      }
      if (key == 'r' || key == 'R') 
      { 
        YVector zop_x =  new YVector(1, 0, 0);
        YVector zop_y =  new YVector(0, 1, 0);
        YVector zop_z =  new YVector(0, 0, 1); 
        float angle_x = dx*PI/240;
        float angle_y = dy*PI/240; 
        float angle_z = dz*PI/240;  
        cmd.Rotate_it(selector, zop_x, -angle_y);
        cmd.Rotate_it(selector, zop_y, angle_x);
        cmd.Rotate_it(selector, zop_z, angle_z);
      }
      if (key == 's' || key == 'S')
      {
        cmd.Select_it(MODE, selector, List_of_Objects, hand_position_last.x - 0.5*height, hand_position_last.y -0.5*width, -(hand_position_last.z -15)*10);
      }
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////    


    BLayer.strokeWeight(22);
    BLayer.strokeCap(ROUND);
    BLayer.stroke(0, 111, 0);
    BLayer.point(hand_position_last.x - 0.5*height, hand_position_last.y -0.5*width, -(hand_position_last.z -15)*10);
    for(Finger finger : hand.getFingers())
    {
    PVector finger_position   = finger.getPosition();
    //int     finger_id         = finger.getId();
    BLayer.strokeWeight(11);
    BLayer.stroke(111,0,0);
    BLayer.point(finger_position.x - 0.5*height,finger_position.y -0.5*width,-(finger_position.z -15)*10);
    }


    hand_position_last = hand_position;
  }
  //println(dy);
  beginCamera();
  camera(0, 0, height/2/ tan(PI*30.0 / 180.0), 0, 0, 0, 0, 1, 0);
  endCamera();

  draw_objects(List_of_Objects, BLayer, selector);

  selector.Draw_Selected_Object(MODE, FLayer, BLayer);

  BLayer.endDraw();

  image(BLayer, -0.5*width, -0.5*height);
  image(FLayer, -0.5*width, -0.5*height); ////////////////////////////////draw_pivot_layer;


  //box(100);
}




void mouseWheel(MouseEvent event)
{

}
///////////////////////////////////////////Commands
void draw_objects(ArrayList<YObject> List_of_Objects, PGraphics BLayer, Selector selector)
{
  int i = 0;
  int j = 0;
  BLayer.beginShape(QUADS);
  BLayer.strokeWeight(1);
  BLayer.stroke(0, 0, 0);
  for (i=0; i<List_of_Objects.size (); i++)
  {
    int flag = 0;
    YObject temp = new YObject(List_of_Objects.get(i));
    //println(temp.Id);
    for ( j =0; j<selector.Selected_Object.size (); j++)
    {
      if (temp.Id == selector.Selected_Object.get(j).Id)
      {
        flag =1;//
        break;
      }
    }
    if (flag!=1)
    {
      temp.DrawFaces(BLayer);
    }
  }
  BLayer.endShape();
}