
//  YVector.pde
//  Modelling System Based on LeapMiton
//
//  Created by yorksero831 on 16/4/13.
//  Copyright © 2016年 SakaiLab-York. All rights reserved.
//

class YVector
{
  float X;
  float Y;
  float Z;
  YVector()
  {
    X = 0;
    Y = 0;
    Z = 0;
  }
  YVector(float x,float y,float z)
  {
    X = x;
    Y = y;
    Z = z;
  }
  YVector(YVector IN)
  {
    X = IN.X;
    Y = IN.Y;
    Z = IN.Z;
  }
  /*
  float getX()
  {
    return X;
  }
  float getY()
  {
    return Y;
  }
  float getZ()
  {
    return Z;
  }
   */
  YVector Add(YVector B)
  {
    YVector C = new YVector(0,0,0);
    C.X = X+B.X;
    C.Y = Y+B.Y;
    C.Z = Z+B.Z;
    return C;  
  }
  YVector Min(YVector B)
  {
    YVector C = new YVector(0,0,0);
    C.X = X-B.X;
    C.Y = Y-B.Y;
    C.Z = Z-B.Z;
    return C;  
  }
  float Dot(YVector B)
  {
    float out;
    out = X*B.X+Y*B.Y+Z*B.Z;
    return out;  
  }
  YVector Cross(YVector B)
  {
    YVector C = new YVector(0,0,0);
    C.X = this.Y*B.Z - this.Z*B.Y;
    C.Y = this.Z*B.X - this.X*B.Z;
    C.Z = this.X*B.Y - this.Y*B.X;
    return C;  
  }
  void Normalize() 
  {
    YVector C = new YVector(0,0,0);
    float temp = sqrt(X*X+Y*Y+Z*Z);
    X = X/temp;
    Y = Y/temp;
    Z = Z/temp; 
  }
  
}