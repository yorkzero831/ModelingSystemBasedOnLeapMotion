
//  YFace.pde
//  Modelling System Based on LeapMiton
//
//  Created by yorksero831 on 16/4/13.
//  Copyright © 2016年 SakaiLab-York. All rights reserved.
//

class YFace
{
   private String flag = "face";
   int Belong_Obj = -1;
   YPoint[] PointsInFace = new YPoint[4];
   YVector[] Pivot = new YVector[4];
   
   ///////////////empty structurer
   YFace()
   {
     this.PointsInFace[0] = new YPoint();
     this.PointsInFace[1] = new YPoint();
     this.PointsInFace[2] = new YPoint();
     this.PointsInFace[3] = new YPoint();
     BulidPivot();
   }
   YFace(YFace IN_Face)
   {
     this.PointsInFace = IN_Face.PointsInFace;
     this.Pivot = IN_Face.Pivot;
     //this.Border = IN_Face.Border;
   }
   
   YFace(YPoint[] points)
   {
     this.PointsInFace = points;
   }

   String getFlag()
   {
     return this.flag;
   }
   String FPoints()
   {
      int i=0;
      String out = ""; 
      for(i=0;i<4;i++)
      {
        out += this.PointsInFace[i].X+","+this.PointsInFace[i].Y+","+this.PointsInFace[i].Z+"  "+this.PointsInFace[i].ID+";  ";
      }
      return out;
   }
   void BulidPivot()
   {
     float xx = 0;
     float yy = 0;
     float zz = 0;
     int i;
     for(i=0;i<4;i++)
     {
       xx += PointsInFace[i].X;
       yy += PointsInFace[i].Y;
       zz += PointsInFace[i].Z;
     }
     Pivot[0] = new YVector((xx/3),(yy/3),(zz/3));
     Pivot[1] = new YVector(1,0,0);
     Pivot[2] = new YVector(0,1,0); 
     Pivot[3] = new YVector(0,0,1);  
   }
   
   
}