class Commands
{
  Commands()
  {
    
  }
  ////////////////////////////========select command======///////////////////////
  void Select_it(String MODE,Selector selector,ArrayList<YObject> List_of_Objects,float x,float y,float z) 
  {
    ///////////////////////////////select obj mode ////////////////////////
    int i = 0;
    int flag_obj = 0;
    if(MODE == "OBJECT MODE")
    {
     if(List_of_Objects.size()==0)
     {
       println("NO Staff in Sence!");
       return;
     }
     for(i = 0; i<List_of_Objects.size();i++)
     {
       println(i);
       YObject temp = new YObject(List_of_Objects.get(i));
       println(IsInBorder(temp,x,y,z));
       if(IsInBorder(temp,x,y,z))
       {
         selector.Clear();
         selector.Add(List_of_Objects.get(i));
         flag_obj =1;
       }
       
     }
     if(flag_obj == 0)
     {
       selector.Clear();
     }
     
    }
    //////////////////////////select point mode /////////////////////////////
    if(MODE == "POINT MODE")
    {
      if(List_of_Objects.size()==0)
      {
        println("NO Staff in Sence!");
        return;
      }
      if(selector.Selected_Object.size()==0)
      {
        println("NO Object Selected!");
        return;     
      }
      int j = 0;
      final float Dis = 10; 
      int flag_point = 0;
      String outout ="";
      for(i = 0;i<selector.Selected_Object.size();i++)
      {
        //YObject temp = selector.Selected_Object.get(i);
        for(j = 0;j<selector.Selected_Object.get(i).Points.length;j++)
        {
           YPoint Cur = new YPoint(x,y,z);
           //outout+= (j+": "+selector.Selected_Object.get(i).Points[j].Distance(Cur)+"; \n");
           //println(outout);
           if(IsClose(selector.Selected_Object.get(i).Points[j],x,y,z,Dis))
           {
             selector.Clear_Point();
             selector.Add(selector.Selected_Object.get(i).Points[j]);
             flag_point++;           
           }
           
        }
        if(flag_point == 0)
        {
          selector.Clear_Point();
        }
        
      }
      println(selector.Selected_Points.size());
    }
    /////////////////////////select face mode //////////////////////////////
    if(MODE == "FACE MODE")
    {
      
    }
     
  }
  boolean IsInBorder(YObject obj,float x,float y,float z)
  {
    float maxX = obj.Border[0].X;
    float minX = obj.Border[0].X;
    float maxY = obj.Border[0].Y;
    float minY = obj.Border[0].X;
    float maxZ = obj.Border[0].Z;
    float minZ = obj.Border[0].X;
    int i = 0;
    for(i =0 ;i<obj.Border.length;i++)
    {
      ////////////////////////get x
      if(obj.Border[i].X>=maxX)
      {
        maxX = obj.Border[i].X;
      }
      if(obj.Border[i].X<=minX)
      {
        minX = obj.Border[i].X;
      }
      ////////////////////////get y
      if(obj.Border[i].Y>=maxY)
      {
        maxY = obj.Border[i].Y;
      }
      if(obj.Border[i].Y<=minY)
      {
        minY = obj.Border[i].Y;
      }
      ////////////////////////get z
      if(obj.Border[i].Z>=maxZ)
      {
        maxZ = obj.Border[i].Z;
      }
      if(obj.Border[i].Z<=minZ)
      {
        minZ = obj.Border[i].Z;
      }
      
    }
    
    //println(maxX+","+minX+"; "+maxY+","+minY+"; "+maxZ+","+minZ+"; "+"-----|"+x+","+y+","+z);
    if(x<=maxX&&x>=minX)
    {
      if(y<=maxY&&y>=minY)
      {
        if(z<=maxZ&&z>=minZ)
        {
          return true;
        }
      }
    }
    return false;
  }
  
  boolean IsClose(YPoint p,float x,float y,float z,float Dis)
  {
    YPoint Cur = new YPoint(x,y,z);
    float tow_Point_dis = Cur.Distance(p);
    if(tow_Point_dis<=Dis)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  ////////////////////////////========Scale command=======///////////////////////
  YVector  Scale_method(float x,float y,float z,char flag,float dis)
  {
    
    float x_fin = dis*x;
    float y_fin = y;
    float z_fin = z;
    switch(flag)
    {
      case 'X':
      {
        x_fin = dis*x;
        y_fin = y;
        z_fin = z;
        break;
      }
      case 'Y':
      {
        x_fin = x;
        y_fin = dis*y;
        z_fin = z;
        break;
      }
      case 'Z':
      {
        x_fin = x;
        y_fin = y;
        z_fin = dis*z;
        break;
      }
      case 'A':
      {
        x_fin = dis*x;
        y_fin = dis*y;
        z_fin = dis*z;
        break;
      }      
    }    
    YVector out = new YVector(x_fin,y_fin,z_fin);
    return out;    
  }
  void Scale_it(Selector selector, char flag,float dis)
  {
    int i = 0;
    int j = 0;
    float x = 0;
    float y = 0;
    float z = 0;
    if(selector.Selected_Object.size()!=0)
    {
      for(i =0;i<selector.Selected_Object.size();i++)
      {
        YObject temp = new YObject(selector.Selected_Object.get(i));
        for(j = 0;j<temp.Points.length;j++)
        {
          x = temp.Points[j].X - temp.Pivot[0].X; 
          y = temp.Points[j].Y - temp.Pivot[0].Y;
          z = temp.Points[j].Z - temp.Pivot[0].Z;
          YVector Fin = Scale_method(x,y,z,flag,dis);
          temp.Points[j].X = Fin.X+temp.Pivot[0].X;
          temp.Points[j].Y = Fin.Y+temp.Pivot[0].Y;
          temp.Points[j].Z = Fin.Z+temp.Pivot[0].Z;
          //println("X="+x+" Y="+y+" Z="+z+" ; X_f="+fin.X+" Y_f="+fin.Y+" Z_f="+fin.Z);
        }
        temp.Update();
      }
      
    }
  }
  ////////////////////////////========rotate command======///////////////////////
  YVector  Rotate_method(float x,float y,float z,YVector p,float r)
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
  void Rotate_it(Selector selector,YVector p,float r)
  {
    int i = 0;
    int j = 0;
    float px = 0;
    float py = 0;
    float pz = 0;
    float x = 0;
    float y = 0;
    float z = 0;
    ///////object///
    if(selector.Selected_Object.size()!=0)
    {
      for(i =0;i<selector.Selected_Object.size();i++)
      {
        
        YObject temp = new YObject(selector.Selected_Object.get(i));
        for(j=1;j<4;j++)
        {
          px = temp.Pivot[j].X ;
          py = temp.Pivot[j].Y ;
          pz = temp.Pivot[j].Z ;
          YVector Fin = Rotate_method(px,py,pz,p,r);
          temp.Pivot[j].X = Fin.X;
          temp.Pivot[j].Y = Fin.Y;
          temp.Pivot[j].Z = Fin.Z;
        }
        
        for(j = 0;j<temp.Points.length;j++)
        {
          x = temp.Points[j].X - temp.Pivot[0].X; 
          y = temp.Points[j].Y - temp.Pivot[0].Y;
          z = temp.Points[j].Z - temp.Pivot[0].Z;
          YVector Fin = Rotate_method(x,y,z,p,r);
          temp.Points[j].X = Fin.X+temp.Pivot[0].X;
          temp.Points[j].Y = Fin.Y+temp.Pivot[0].Y;
          temp.Points[j].Z = Fin.Z+temp.Pivot[0].Z;
        }
        temp.Update();
      }
    }
    
  }
  
  ////////////////////////////========move command========///////////////////////
  void Move(String MODE,Selector selector,float dx,float dy,float dz)
  {
    int i = 0;
    int j = 0;
    ///////object///
    if(MODE == "OBJECT MODE" )
    {
      if(selector.Selected_Object.size()!=0)
      {
        for(i =0;i<selector.Selected_Object.size();i++)
        {
        
          selector.Selected_Object.get(i).Pivot[0].X += dx;
          selector.Selected_Object.get(i).Pivot[0].Y += dy;
          selector.Selected_Object.get(i).Pivot[0].Z += dz;
          /////////////update Points/////////////////////
          for(j = 0;j<selector.Selected_Object.get(i).Points.length;j++)
          {
            selector.Selected_Object.get(i).Points[j].X += dx; 
            selector.Selected_Object.get(i).Points[j].Y += dy;
            selector.Selected_Object.get(i).Points[j].Z += dz;
          }       
          selector.Selected_Object.get(i).Update();
        }
      }
    }
    /////////point////
    if(MODE == "POINT MODE" )
    {
      if(selector.Selected_Object.size()==0)
      {
        println("NO Object Selected");
        return;
      }
      if(selector.Selected_Points.size()!=0)
      {
        for(i =0;i<selector.Selected_Points.size();i++)
        {
          /////////////update Points/////////////////////
          selector.Selected_Points.get(i).X += dx; 
          selector.Selected_Points.get(i).Y += dy; 
          selector.Selected_Points.get(i).Z += dz;                
        }
        ////////////fing where Point in//////////////////
        //GetObject(selector,selector.Selected_Points.get(i)).Update();
      }
    }
    
    
    
  }
  
  //////////////////////////=========get the Object===========//////////////////////////////////////////
  YObject GetObject(Selector selector,YPoint p)
  {
    int find_Flag = p.Belong_Obj;
    int i = 0;
    for(i = 0;i<selector.Selected_Object.size();i++)
    {
      if(find_Flag == selector.Selected_Object.get(i).Id)
      {
        return selector.Selected_Object.get(i);
      }
      else
      {
        return null;
      }
    }
    return null;
  }
  YObject GetObject(Selector selector,YFace f)
  {
    int find_Flag = f.Belong_Obj;
    int i = 0;
    for(i = 0;i<selector.Selected_Object.size();i++)
    {
      if(find_Flag == selector.Selected_Object.get(i).Id)
      {
        return selector.Selected_Object.get(i);
      }
      else
      {
        return null;
      }
    }
    return null;
  }
  
  //////////////////////////===========bulid Cube=============//////////////////////////////////////////
  //void Cube(float Cube_Length,float Cube_width,float  Cube_higth,int L_Step,int W_Step,int H_Step,YPoint[] Position)
  YObject Cube(float Cube_Length,float Cube_width,float  Cube_higth,int L_Step,int W_Step,int H_Step)
  {
    String Temp ="";
    int number_of_faces = 2*L_Step*W_Step + 2*L_Step*H_Step + 2*W_Step*H_Step;
    YFace[] faces = new YFace[number_of_faces];
    
    ////////////////////////////////////////////////////////////////
    
    
    YFace[] face_buttom = new YFace[L_Step*W_Step];
    YFace[] face_up = new YFace[L_Step*W_Step];
    YFace[] face_front = new YFace[L_Step*H_Step];
    YFace[] face_back = new YFace[L_Step*H_Step];
    YFace[] face_left = new YFace[W_Step*H_Step];
    YFace[] face_right = new YFace[W_Step*H_Step];
    ////////////////////////////////////////////////////////////////////
    
    int number = (L_Step+1)*(W_Step+1)*(H_Step+1) - (L_Step-1)*(W_Step-1)*(H_Step-1);
    YPoint[] points = new YPoint[number];
    YPoint p1 = new YPoint(1,1,1);
    YObject obj = new YObject();
    int h,l,w,i;
    int index = -1;
    YPoint[] points_on_Front = new YPoint[(L_Step+1)*(H_Step+1)];
    YPoint[] points_on_Back = new YPoint[(L_Step+1)*(H_Step+1)];
    YPoint[] points_on_Left = new YPoint[(W_Step+1)*(H_Step+1)];
    YPoint[] points_on_Right = new YPoint[(W_Step+1)*(H_Step+1)];
    
 //////////////////////////// Build Point Data//////////////////////////////////////
    for(h = 0; h<(H_Step+1); h++)
    {
      for(l = 0; l<(L_Step+1);l++)
      {
        for(w = 0; w<(W_Step+1); w++)
        {
          float v_h = -0.5*Cube_higth+(h*Cube_higth)/H_Step;
          float v_w = 0.5*Cube_width-(w*Cube_width)/W_Step;
          float v_l = 0.5*Cube_Length-(l*Cube_Length)/L_Step;
          YPoint temp_p;
          if(h==0||h==H_Step)
          {     
            temp_p = new YPoint(v_l,v_h,v_w,index+1);
            index++;
          }
          else
          {
            if(w==0||w==W_Step)
            {
              temp_p = new YPoint(v_l,v_h,v_w,index+1);
              index++;
            }
            else if(l==0||l==L_Step)
            {
              temp_p = new YPoint(v_l,v_h,v_w,index+1);
              index++;
            }
            else
            {
              continue;
            }            
          }
          points[index]=temp_p;
        }
      }    
    }
    
///////////////////////////////////////----Bulid Face Data-----////////////////////////////
    int face_count =0;
    int n,m;
    int distance;
    int tempIndex[] = new int[4];
    YFace tempFace;
    YPoint[] tempPoints = new YPoint[4]; 
    //////////////////////////////////////Face_Buttom///////////////////////////////////////////
      face_count = 0;
      for(n=0;n<L_Step;n++)
      {
        for(m=0;m<W_Step;m++)
        {
          distance = 0;
          tempIndex[0] = m+(W_Step+1)*n;
          tempIndex[1] = m+(W_Step+1)*(n+1);
          tempIndex[2] = m+1+(W_Step+1)*(n+1);
          tempIndex[3] = m+1+(W_Step+1)*n;
          tempPoints = new YPoint[4];
          tempPoints[0] = points[tempIndex[0]];
          tempPoints[1] = points[tempIndex[1]];
          tempPoints[2] = points[tempIndex[2]];
          tempPoints[3] = points[tempIndex[3]];
          faces[face_count] = new YFace(tempPoints);
          //face_buttom[face_count] = new YFace(tempPoints);
          //println( "face_buttom: "+face_buttom[face_count].FPoints());
          face_count++;
        }
      } 
   ////////////////////////////////////////Face_Up//////////////////////////////////////////
     //face_count =0;
     for(n=0;n<L_Step;n++)
      {
        for(m=0;m<W_Step;m++)
        {
          distance = (L_Step+1)*(W_Step+1)*(H_Step) - (L_Step-1)*(W_Step-1)*(H_Step-1);
          tempIndex[0] = m+(W_Step+1)*n+distance;
          tempIndex[1] = m+(W_Step+1)*(n+1)+distance;
          tempIndex[2] = m+1+(W_Step+1)*(n+1)+distance;
          tempIndex[3] = m+1+(W_Step+1)*n+distance;
          tempPoints = new YPoint[4];
          tempPoints[0] = points[tempIndex[0]];
          tempPoints[1] = points[tempIndex[1]];
          tempPoints[2] = points[tempIndex[2]];
          tempPoints[3] = points[tempIndex[3]];
          faces[face_count] = new YFace(tempPoints);
          //face_up[face_count] = new YFace(tempPoints);
          //println( "face_up: "+face_up[face_count].FPoints());
          face_count++;
        }
      }
  //////////////////////////////Get Four Faces Points////////////////////////////////
     int temp_counter_front = 0;
     int temp_counter_back = 0;
     int temp_counter_left = 0;
     int temp_counter_right = 0;
     for(i=0;i<number;i++)
     {
       //////////////////////////Front_Face_points////////////////////////////
        if(points[i].Z==(0.5*Cube_width))
        {
          points_on_Front[temp_counter_front] = points[i];
          //println("front:"+points_on_Front[temp_counter_front].X+","+points_on_Front[temp_counter_front].Y+","+points_on_Front[temp_counter_front].Z);
          temp_counter_front++;
        }
       //////////////////////////Back_Face_points////////////////////////////
        if(points[i].Z==(-0.5*Cube_width))
        {
          points_on_Back[temp_counter_back] = points[i];
          //println("back:"+points_on_Back[temp_counter_back].X+","+points_on_Back[temp_counter_back].Y+","+points_on_Back[temp_counter_back].Z);
          temp_counter_back++;
        }
        //////////////////////////Lift_Face_points////////////////////////////
        if(points[i].X==(0.5*Cube_Length))
        {
          points_on_Left[temp_counter_left] = points[i];
          temp_counter_left++;
        }
        //////////////////////////Right_Face_points////////////////////////////
        if(points[i].X==(-0.5*Cube_Length))
        {
          points_on_Right[temp_counter_right] = points[i];
          temp_counter_right++;
        }
     }
     
    // println(temp_counter_front+" "+temp_counter_back+" "+temp_counter_left+" "+temp_counter_right);
     ////////////////////////////////////////////////////////////////////////////////////////////
     
   ////////////////////////////////////////Face_Front//////////////////////////////////////////
     //tempPoints = new YPoint[4];
     //face_count = 0;
     for(n=0;n<H_Step;n++)
     {
       for(m=0;m<L_Step;m++)
       {
         tempIndex[0] = m+(L_Step+1)*n;
         tempIndex[1] = m+(L_Step+1)*n+1;
         tempIndex[2] = m+(L_Step+1)*(n+1)+1;
         tempIndex[3] = m+(L_Step+1)*(n+1);
         tempPoints = new YPoint[4];  
         tempPoints[0] = points_on_Front[tempIndex[0]];
         tempPoints[1] = points_on_Front[tempIndex[1]];
         tempPoints[2] = points_on_Front[tempIndex[2]];
         tempPoints[3] = points_on_Front[tempIndex[3]];
         
         faces[face_count] = new YFace(tempPoints);
         //face_front[face_count] = new YFace(tempPoints);
         //println( "face_front: "+face_front[face_count].FPoints());
         face_count++;
       }
     } 
   /////////////////////////////////////////////////////////////////////////////////////////////
   
   ////////////////////////////////////////Face_Back//////////////////////////////////////////
     //face_count = 0;
     for(n=0;n<H_Step;n++)
     {
       for(m=0;m<L_Step;m++)
       {
         tempIndex[0] = m+(L_Step+1)*n;
         tempIndex[1] = m+(L_Step+1)*n+1;
         tempIndex[2] = m+(L_Step+1)*(n+1)+1;
         tempIndex[3] = m+(L_Step+1)*(n+1);
         tempPoints = new YPoint[4];  
         tempPoints[0] = points_on_Back[tempIndex[0]];
         tempPoints[1] = points_on_Back[tempIndex[1]];
         tempPoints[2] = points_on_Back[tempIndex[2]];
         tempPoints[3] = points_on_Back[tempIndex[3]];
         faces[face_count] = new YFace(tempPoints);
         //face_back[face_count] = new YFace(tempPoints);
         face_count++;
       }
     } 
   /////////////////////////////////////////////////////////////////////////////////////////////  
   
////////////////////////////////////////Face_Left//////////////////////////////////////////
     //face_count = 0;
     for(n=0;n<H_Step;n++)
     {
       for(m=0;m<W_Step;m++)
       {
         tempIndex[0] = m+(W_Step+1)*n;
         tempIndex[1] = m+(W_Step+1)*n+1;
         tempIndex[2] = m+(W_Step+1)*(n+1)+1;
         tempIndex[3] = m+(W_Step+1)*(n+1);
         tempPoints = new YPoint[4];  
         tempPoints[0] = points_on_Left[tempIndex[0]];
         tempPoints[1] = points_on_Left[tempIndex[1]];
         tempPoints[2] = points_on_Left[tempIndex[2]];
         tempPoints[3] = points_on_Left[tempIndex[3]];
         faces[face_count] = new YFace(tempPoints);
         //face_left[face_count] = new YFace(tempPoints);
         face_count++;
       }
     } 
   /////////////////////////////////////////////////////////////////////////////////////////////  
   
////////////////////////////////////////Face_Right//////////////////////////////////////////
     //face_count = 0;
     for(n=0;n<H_Step;n++)
     {
       for(m=0;m<W_Step;m++)
       {
         tempIndex[0] = m+(W_Step+1)*n;
         tempIndex[1] = m+(W_Step+1)*n+1;
         tempIndex[2] = m+(W_Step+1)*(n+1)+1;
         tempIndex[3] = m+(W_Step+1)*(n+1);
         tempPoints = new YPoint[4];  
         tempPoints[0] = points_on_Right[tempIndex[0]];
         tempPoints[1] = points_on_Right[tempIndex[1]];
         tempPoints[2] = points_on_Right[tempIndex[2]];
         tempPoints[3] = points_on_Right[tempIndex[3]];
         faces[face_count] = new YFace(tempPoints);
         //face_right[face_count] = new YFace(tempPoints);
         face_count++;
       }
     } 
   ///////////////////////////////////////////////////////////////////////////////////////////// 
  //for (i=0;i<number_of_faces;i++)
  //{
  // println( faces[i].FPoints() );
  //}
  
  YObject outObj = new YObject(faces,points);
  return outObj;
 }
     
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
