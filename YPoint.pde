
//  YPoint.pde
//  Modelling System Based on LeapMiton
//
//  Created by yorksero831 on 16/4/13.
//  Copyright © 2016年 SakaiLab-York. All rights reserved.
//

class YPoint 
{
  private String flag = "point";
  YVector Pivot[] = new YVector[4];
  int ID = -1;
  int Belong_Obj = -1;
  float X;
  float Y;
  float Z;
  float U;
  float V;
  YPoint()
  {
    this.X = 0;
    this.Y = 0;
    this.Z = 0;
    this.U = 0;
    this.V = 0;
    this.ID = -1;
  }
  YPoint(YPoint P)
  {
    this.Belong_Obj = P.Belong_Obj;
    this.X = P.X;
    this.Y = P.Y;
    this.Z = P.Z;
    this.U = P.U;
    this.V = P.V;
    this.ID = P.ID;
  }
  YPoint(float x,float y,float z)
  {
    this.X = x;
    this.Y = y;
    this.Z = z;
    this.U = 0;
    this.V = 0;
  }
  YPoint(float x,float y,float z,int id)
  {
    this.X = x;
    this.Y = y;
    this.Z = z;
    this.U = 0;
    this.V = 0;
    this.ID = id;
  }
  YPoint(float x,float y,float z,float u,float v)
  {
    this.X = x;
    this.Y = y;
    this.Z = z;
    this.U = u;
    this.V = v;
  }
  void  initialise_Pivot(float x,float y,float z)
  {
    this.Pivot[0] = new YVector(x,y,z);
    this.Pivot[1] = new YVector(1,0,0);
    this.Pivot[2] = new YVector(0,1,0);
    this.Pivot[3] = new YVector(0,0,1);
  }
  YPoint Add(YPoint PB)
  {
    YPoint out = new YPoint();
    out.X = PB.X+this.X;
    out.Y = PB.Y+this.Y;
    out.Z = PB.Z+this.Z;
    return out;
  }
  float Distance(YPoint IN)
  {
     float dis = sqrt((this.X-IN.X)*(this.X-IN.X) + (this.Y-IN.Y)*(this.Y-IN.Y) + (this.Z-IN.Z)*(this.Z-IN.Z));
     return dis;
  }
  
  String getFlag()
  {
    return this.flag;
  }
  String PPoint()
  {
    String out = "";
    out += this.X +","+this.Y+","+this.Z+" "+this.ID;
    return out;
  }
   
   
}