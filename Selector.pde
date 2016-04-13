
//  Selector.pde
//  Modelling System Based on LeapMiton
//
//  Created by yorksero831 on 16/4/13.
//  Copyright © 2016年 SakaiLab-York. All rights reserved.
//

class Selector
{
  ArrayList<YObject> Selected_Object = new ArrayList<YObject>(); 
  ArrayList<YFace> Selected_Faces = new ArrayList<YFace>();
  ArrayList<YPoint> Selected_Points = new ArrayList<YPoint>();
  Selector()
  {
    
  }
  void Add(YObject o)
  {
    Selected_Object.add(o);
    Selected_Faces = new ArrayList<YFace>();
    Selected_Points = new ArrayList<YPoint>();
  }
  void Add(YFace f)
  {
    Selected_Faces.add(f);
    Selected_Points = new ArrayList<YPoint>();
  }
  void Add(YPoint p)
  {
    Selected_Points.add(p);
    Selected_Faces = new ArrayList<YFace>();
  }
  void Clear()
  {
    Selected_Object = new ArrayList<YObject>(); 
    Selected_Faces = new ArrayList<YFace>();
    Selected_Points = new ArrayList<YPoint>();    
  }
  void Clear_Point()
  {
    Selected_Points = new ArrayList<YPoint>(); 
  }
  void Clear_Face()
  {
    Selected_Faces = new ArrayList<YFace>();
  }
  
  void Draw_Selected_Object(String MODE,PGraphics FLayer,PGraphics BLayer)
  {
    int num = Selected_Object.size();
    if(num == 0)
    {
      return;
    }
    int i = 0; 
    
    if(MODE == "OBJECT MODE")
    {   
      BLayer.beginShape(QUADS);
      BLayer.smooth(2);
      BLayer.strokeWeight(2);
      BLayer.strokeCap(ROUND);
      BLayer.stroke(0,255,111);
      for(i = 0;i<num;i++)
      {
        YObject temp = new YObject(Selected_Object.get(i));
        temp.DrawFaces(BLayer);
      }
      BLayer.endShape();
    
      FLayer.beginDraw();
      FLayer.camera(0, 0,height/2/ tan(PI*30.0 / 180.0) , 0, 0, 0, 0, 1, 0);
      FLayer.background(0,0,0,0);
      for(i = 0;i<num;i++)
      {
        YObject temp = new YObject(Selected_Object.get(i));
        float times = 100;
        FLayer.stroke(255,0,0);
        FLayer.line(temp.Pivot[0].X,temp.Pivot[0].Y,temp.Pivot[0].Z,(temp.Pivot[0].X+temp.Pivot[1].X*times),(temp.Pivot[0].Y+temp.Pivot[1].Y*times),(temp.Pivot[0].Z+temp.Pivot[1].Z*times));
        FLayer.stroke(0,255,0);
        FLayer.line(temp.Pivot[0].X,temp.Pivot[0].Y,temp.Pivot[0].Z,(temp.Pivot[0].X+temp.Pivot[2].X*times),(temp.Pivot[0].Y+temp.Pivot[2].Y*times),(temp.Pivot[0].Z+temp.Pivot[2].Z*times));
        FLayer.stroke(0,0,255);
        FLayer.line(temp.Pivot[0].X,temp.Pivot[0].Y,temp.Pivot[0].Z,(temp.Pivot[0].X+temp.Pivot[3].X*times),(temp.Pivot[0].Y+temp.Pivot[3].Y*times),(temp.Pivot[0].Z+temp.Pivot[3].Z*times));
      }
      FLayer.endDraw();
    }
    if(MODE == "POINT MODE")
    {
      ///////draw face//////
      BLayer.beginShape(QUADS);
      BLayer.smooth(2);
      BLayer.strokeWeight(2);
      BLayer.strokeCap(ROUND);
      BLayer.stroke(0,255,111);
      for(i = 0;i<num;i++)
      {
        YObject temp = new YObject(Selected_Object.get(i));
        temp.DrawFaces(BLayer);
      }
      BLayer.endShape();
      ///////draw point////////
      BLayer.beginShape(POINTS);
      //BLayer.smooth(3);
      BLayer.strokeWeight(7);
      BLayer.strokeCap(ROUND);
      BLayer.stroke(0,0,255);
      for(i = 0;i<Selected_Points.size();i++)
      {
        BLayer.vertex(Selected_Points.get(i).X,Selected_Points.get(i).Y,Selected_Points.get(i).Z);
      }
      BLayer.endShape();
      
      
      FLayer.beginDraw();
      FLayer.camera(0, 0,height/2/ tan(PI*30.0 / 180.0) , 0, 0, 0, 0, 1, 0);
      FLayer.background(0,0,0,0);
      for(i = 0;i<Selected_Points.size();i++)
      {
        float times = 50;
        FLayer.stroke(255,0,0);
        FLayer.line(Selected_Points.get(i).X,Selected_Points.get(i).Y,Selected_Points.get(i).Z,(Selected_Points.get(i).X+1*times),(Selected_Points.get(i).Y+0*times),(Selected_Points.get(i).Z+0*times));
        FLayer.stroke(0,255,0);
        FLayer.line(Selected_Points.get(i).X,Selected_Points.get(i).Y,Selected_Points.get(i).Z,(Selected_Points.get(i).X+0*times),(Selected_Points.get(i).Y+1*times),(Selected_Points.get(i).Z+0*times));
        FLayer.stroke(0,0,255);
        FLayer.line(Selected_Points.get(i).X,Selected_Points.get(i).Y,Selected_Points.get(i).Z,(Selected_Points.get(i).X+0*times),(Selected_Points.get(i).Y+0*times),(Selected_Points.get(i).Z+1*times));
      }
      FLayer.endDraw();
    }
    
    
  }
  
  ///////////////////////////////////////////////////
}