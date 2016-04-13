
//  YObject.pde
//  Modelling System Based on LeapMiton
//
//  Created by yorksero831 on 16/4/13.
//  Copyright © 2016年 SakaiLab-York. All rights reserved.
//

class YObject
{
  YID Yid = new YID();
  int Id = Yid.id;
  String Name = ""; 
  YFace[] Faces ;
  YPoint[] Points;
  YPoint[] Border = new YPoint[8];
  YVector[] Pivot = new YVector[4];
  ///////////////empty structurer
  YObject()
  {
    Faces = new YFace[1];
    Points = new YPoint[1];
  }
  YObject(YObject IN)
  {
    int i = 0;
    this.Id = IN.Id;
    this.Faces = new YFace[IN.Faces.length];
    this.Faces = IN.Faces;
    for(i = 0;i<this.Faces.length;i++)
    {
      this.Faces[i].Belong_Obj  = Id;
    }
    
    this.Points = new YPoint[IN.Points.length];
    this.Points = IN.Points;
    for(i = 0;i<this.Points.length;i++)
    {
      this.Points[i].Belong_Obj = Id;
    }
    
    this.Border = IN.Border;
    this.Pivot = IN.Pivot;
  }
  YObject(YFace[] faces,YPoint[] points)
  {
    int i = 0;
    this.Faces = faces;
    this.Points = points;
    for(i = 0;i<this.Faces.length;i++)
    {
      this.Faces[i].Belong_Obj  = Id;
    }
    for(i = 0;i<this.Points.length;i++)
    {
      this.Points[i].Belong_Obj = Id;
    }
    BulidBorder();
    BulidPivot();
  }
  YObject(YPoint[] points)
  {
    int i = 0;
    this.Faces = new YFace[1];
    this.Points = points;
    for(i = 0;i<this.Faces.length;i++)
    {
      this.Faces[i].Belong_Obj  = Id;
    }
    for(i = 0;i<this.Points.length;i++)
    {
      this.Points[i].Belong_Obj = Id;
    }
    BulidBorder();
    BulidPivot();
  }
  
  void Update()
  {
    /////////update Face and Point
    int i =0;
    for(i = 0;i<Faces.length;i++)
    {
      this.Faces[i].PointsInFace[0] =  this.Points[this.Faces[i].PointsInFace[0].ID];
      this.Faces[i].PointsInFace[1] =  this.Points[this.Faces[i].PointsInFace[1].ID];
      this.Faces[i].PointsInFace[2] =  this.Points[this.Faces[i].PointsInFace[2].ID];
      this.Faces[i].PointsInFace[3] =  this.Points[this.Faces[i].PointsInFace[3].ID];
    }
    
    /////////update Povit
    
    ///////update Border
    
     BulidBorder();
    
  }
  
  
  void DrawPoints()
  {
    int i =0;
    for(i=0;i<Points.length;i++)
    {
      //stroke(204, 102, 0);
      point(Points[i].X,Points[i].Y,Points[i].Z);
    }
  }
  void DrawFaces(PGraphics BLayer)
  {
    int i=0;
    for(i=0;i<Faces.length;i++)
    {
      BLayer.vertex(Faces[i].PointsInFace[0].X,Faces[i].PointsInFace[0].Y,Faces[i].PointsInFace[0].Z,Faces[i].PointsInFace[0].U,Faces[i].PointsInFace[0].V);
      BLayer.vertex(Faces[i].PointsInFace[1].X,Faces[i].PointsInFace[1].Y,Faces[i].PointsInFace[1].Z,Faces[i].PointsInFace[1].U,Faces[i].PointsInFace[1].V);
      BLayer.vertex(Faces[i].PointsInFace[2].X,Faces[i].PointsInFace[2].Y,Faces[i].PointsInFace[2].Z,Faces[i].PointsInFace[2].U,Faces[i].PointsInFace[2].V);
      BLayer.vertex(Faces[i].PointsInFace[3].X,Faces[i].PointsInFace[3].Y,Faces[i].PointsInFace[3].Z,Faces[i].PointsInFace[3].U,Faces[i].PointsInFace[3].V);
    }
  }
  void BulidBorder()
  {
    ///////find border X
    float max = Points[0].X;
    float min = Points[0].X;
    int i = 0;
    for(i=0;i<Points.length;i++)
    {
      if(Points[i].X<=min)
      {
        min = Points[i].X;
      }
      if(Points[i].X>=max)
      {
        max = Points[i].X;
      }
    }
    
    ///////find border Y
    float max_Y = Points[0].Y;
    float min_Y = Points[0].Y;
    for(i=0;i<Points.length;i++)
    {
      if(Points[i].Y<=min_Y)
      {
        min_Y = Points[i].Y;
      }
      if(Points[i].Y>=max_Y)
      {
        max_Y = Points[i].Y;
      }
    }
    
  ////////find border Z
    float max_Z = Points[0].Z;
    float min_Z = Points[0].Z;
    for(i=0;i<Points.length;i++)
    {
      if(Points[i].Z<=min_Z)
      {
        min_Z = Points[i].Z;
      }
      if(Points[i].Z>=max_Z)
      {
        max_Z = Points[i].Z;
      }
    }
    
    Border[0] = new YPoint(max+1,max_Y+1,min_Z-1);
    Border[1] = new YPoint(max+1,min_Y-1,min_Z-1);
    Border[2] = new YPoint(min-1,min_Y-1,min_Z-1);
    Border[3] = new YPoint(min-1,max_Y+1,min_Z-1);
    //////////////
    Border[4] = new YPoint(max+1,max_Y+1,max_Z+1);
    Border[5] = new YPoint(max+1,min_Y-1,max_Z+1);
    Border[6] = new YPoint(min-1,min_Y-1,max_Z+1);
    Border[7] = new YPoint(min-1,max_Y+1,max_Z+1);
    //String outputmm = "";
    //for(i=0;i<8;i++)
    //{
    //  outputmm += Border[i].PPoint()+"\n";
    //}
    //println(outputmm);
  }
  
  void BulidPivot()
  {
    int i =0;
    YPoint outPivot = new YPoint();
    for(i=0;i<8;i++)
    {
      outPivot = outPivot.Add(Border[i]);
    }
    this.Pivot[0] =new YVector(outPivot.X/8,outPivot.Y/8,outPivot.Z/8);
    //this.Pivot[0].Y = outPivot.Y/8;
   // this.Pivot[0].Z = outPivot.Z/8;
    
    this.Pivot[1] = new YVector(1,0,0);
    this.Pivot[2] = new YVector(0,1,0);
    this.Pivot[3] = new YVector(0,0,1);
    
  }
}void RotateObject()
{
  
}

YVector Rotate(float x,float y,float z,YVector p,float r)
{
  float a0 = cos(r)+(1-cos(r))*p.X*p.X;
  float a1 = (1-cos(r))*p.Y*p.X + sin(r)*p.Z;
  float a2 = (1-cos(r))*p.Z*p.X - sin(r)*p.Y;
  
  float b0 = (1-cos(r))*p.Y*p.X - sin(r)*p.Z;
  float b1 = cos(r)+(1-cos(r))*p.Y*p.Y;
  float b2 = (1-cos(r))*p.Y*p.Z + sin(r)*p.X;
  
  float c0 = (1-cos(r))*p.Z*p.X + sin(r)*p.Y;
  float c1 = (1-cos(r))*p.Y*p.Z - sin(r)*p.X;
  float c2 = cos(r)+(1-cos(r))*p.Z*p.Z;
  
  YVector A = new YVector(a0,a1,a2);
  YVector B = new YVector(b0,b1,b2);
  YVector C = new YVector(c0,c1,c2);
  YVector in = new YVector(x,y,z);
  
  YVector out = new YVector(A.Dot(in),B.Dot(in),C.Dot(in));
  return out;
  
  
}