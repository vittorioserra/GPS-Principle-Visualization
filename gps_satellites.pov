#include "colors.inc"
#include "textures.inc"


#ifndef (CamType) // if this variable is not set (here or in the .ini file), default to "outside" camera
	camera
    {
    	location <25.0, 25.0, -25.0>  //25, 25, -25
    	look_at <15/4+sqrt(167)/4,0,15/4-sqrt(167)/4>  //0,0,0
    	right x*image_width/image_height
    }
	#declare sky_scale = 0.002;
#end  

  

#declare glass_transmission_coeff = 0.9;  
#declare glass_reflection = 0.1;
#declare glass_ior = 1; //change ior to 1 (from 1.5 originally) to make everything go way faster  
#declare on_transmission_coeff = 0; 
#declare on_glass_transmission_coeff = 0.3;
#declare off_transmission = glass_transmission_coeff;  
#declare off_glass_transmission_coeff =  off_transmission;   
#declare r_earth = 0;


#declare ring_12_t = 1;
#declare ring_13_t = 1; 
#declare ring_23_t = 1; 
#declare ring_14_t = 1;
#declare ring_24_t = 1;
#declare ring_34_t = 1;


#declare ring_12_th = 0;
#declare ring_13_th = 0; 
#declare ring_23_th = 0; 
#declare ring_14_th = 0;
#declare ring_24_th = 0;
#declare ring_34_th = 0; 

 
#declare ring_12_r = 0;
#declare ring_13_r = 0; 
#declare ring_23_r = 0; 
#declare ring_14_r = 0;
#declare ring_24_r = 0;
#declare ring_34_r = 0;   

#declare sphere_1_t =  off_transmission;
#declare sphere_2_t =  off_transmission;
#declare sphere_3_t =  off_transmission;
#declare sphere_4_t =  off_transmission;     

#declare transmit_point = 0;  


#switch (clock) // full turn on each axis
	#range(0,1)
	    //things to do in the first section : a) spere 1 should expand
	    #declare local_clock = clock;
		#declare sphere_1_radius = 7 * (clock); 
		#declare sphere_2_radius = 0;
		#declare sphere_3_radius = 0; 
		#declare sphere_4_radius = 0;   
		#declare sphere_1_t = on_glass_transmission_coeff;
	#break 
	#range(1,2)
	    //sphere 2 expands, sphere 1 is already expanded
	    #declare sphere_1_t = off_glass_transmission_coeff;
	    #declare sphere_2_t = on_glass_transmission_coeff;   
	    #declare local_clock = clock-1;
		#declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7 * (local_clock);
		#declare sphere_3_radius = 0; 
		#declare sphere_4_radius = 0;
	#break
	#range(2,3)
	    //intersection ring appears, hence gradually change it's transmission coefficent
	    #declare local_clock = clock-2;
	    #declare ring_12_th = 1/3;
	    #declare ring_12_t = 1 - (local_clock);
	    
	    #declare sphere_1_t = off_glass_transmission_coeff;
	    #declare sphere_2_t = off_glass_transmission_coeff;
	    
	    #declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7;
		#declare sphere_3_radius = 0; 
		#declare sphere_4_radius = 0;
	#break
	#range(3,4)
	    //intersection ring disappears, hence gradually change it's transmission coefficent
	    #declare local_clock = clock-3;
	    #declare ring_12_th = 1/3;
	    #declare ring_12_t = (local_clock);   
	          	    
	    #declare sphere_1_t = off_glass_transmission_coeff;
	    #declare sphere_2_t = off_glass_transmission_coeff;
	    
	    #declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7;
		#declare sphere_3_radius = 0; 
		#declare sphere_4_radius = 0;
	#break
	#range(4,5)
	    //sphere 3 expands
	    #declare sphere_1_t = off_glass_transmission_coeff;
	    #declare sphere_2_t = off_glass_transmission_coeff; 
	    #declare sphere_3_t = on_glass_transmission_coeff; 
	    
	    #declare local_clock = clock-4;
	    #declare ring_12_th = 1/3;
	    #declare ring_12_t = off_transmission;
	    #declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7;
		#declare sphere_3_radius = 7 * (local_clock);
		#declare sphere_4_radius = 0;
	#break
	
	#range(5,6)
	    //fade in of rings 23 and 13
	    #declare sphere_1_t = off_glass_transmission_coeff;
	    #declare sphere_2_t = off_glass_transmission_coeff; 
	    #declare sphere_3_t = off_glass_transmission_coeff; 
	    
	    #declare local_clock = clock-5;
	    #declare ring_12_th = 1/3;
	    #declare ring_12_t = off_transmission;
	    #declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7;
		#declare sphere_3_radius = 7;
		#declare sphere_4_radius = 0; 
		
		#declare ring_23_th = 1/3;
	    #declare ring_23_t = 1 - (local_clock);
	    #declare ring_13_th = 1/3;
	    #declare ring_13_t = 1 - (local_clock);
	#break
	
	#range(6,7)
	    //fade out of rings 23 and 13
	    #declare sphere_1_t = off_glass_transmission_coeff;
	    #declare sphere_2_t = off_glass_transmission_coeff; 
	    #declare sphere_3_t = off_glass_transmission_coeff; 
	    
	    #declare local_clock = clock-6;
	    #declare ring_12_th = 1/3;
	    #declare ring_12_t = off_transmission;
	    #declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7;
		#declare sphere_3_radius = 7;
		#declare sphere_4_radius = 0; 
		
		#declare ring_23_th = 1/3;
	    #declare ring_23_t = (local_clock);
	    #declare ring_13_th = 1/3;
	    #declare ring_13_t = (local_clock);
	#break
	
	#range(7,8)
	    //sphere 4 expands  
	    #declare sphere_1_t = off_glass_transmission_coeff;
	    #declare sphere_2_t = off_glass_transmission_coeff; 
	    #declare sphere_3_t = off_glass_transmission_coeff;  
	    #declare sphere_4_t = on_glass_transmission_coeff; 
	    #declare ring_12_th = 1/3;
	    #declare ring_12_t = off_transmission;
	    #declare ring_23_th = 1/3;
	    #declare ring_23_t = off_transmission;
	    #declare ring_13_th = 1/3;
	    #declare ring_13_t = off_transmission;
	
	    #declare local_clock = clock-7;
	
		#declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7;
		#declare sphere_3_radius = 7;
		#declare sphere_4_radius = 10 * (local_clock);
	#break
	
	#range(8,9)
	    //fade in of rings 14, 24 and 34  
	    #declare sphere_1_t = off_glass_transmission_coeff;
	    #declare sphere_2_t = off_glass_transmission_coeff; 
	    #declare sphere_3_t = off_glass_transmission_coeff;  
	    #declare sphere_4_t = off_glass_transmission_coeff; 
	    #declare ring_12_th = 1/3;
	    #declare ring_12_t = off_transmission;
	    #declare ring_23_th = 1/3;
	    #declare ring_23_t = off_transmission;
	    #declare ring_13_th = 1/3;
	    #declare ring_13_t = off_transmission;
	
	    #declare local_clock = clock-8;
	
		#declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7;
		#declare sphere_3_radius = 7;
		#declare sphere_4_radius = 10;  
		
		#declare ring_14_th = 1/3;
	    #declare ring_14_t = 1 - (local_clock);
	    #declare ring_24_th = 1/3;
	    #declare ring_24_t = 1 - (local_clock);
	    #declare ring_34_th = 1/3;
	    #declare ring_44_t = 1 - (local_clock);
	#break
	
	#range(9,10)
	    //fade out of rings 14, 24 and 34  
	    #declare sphere_1_t = off_glass_transmission_coeff;
	    #declare sphere_2_t = off_glass_transmission_coeff; 
	    #declare sphere_3_t = off_glass_transmission_coeff;  
	    #declare sphere_4_t = off_glass_transmission_coeff; 
	    #declare ring_12_th = 1/3;
	    #declare ring_12_t = off_transmission;
	    #declare ring_23_th = 1/3;
	    #declare ring_23_t = off_transmission;
	    #declare ring_13_th = 1/3;
	    #declare ring_13_t = off_transmission;
	
	    #declare local_clock = clock-9;
	
		#declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7;
		#declare sphere_3_radius = 7;
		#declare sphere_4_radius = 10;  
		
		#declare ring_14_th = 1/3;
	    #declare ring_14_t = (local_clock);
	    #declare ring_24_th = 1/3;
	    #declare ring_24_t = (local_clock);
	    #declare ring_34_th = 1/3;
	    #declare ring_44_t = (local_clock);
	#break  
	
	#range(10,12) 
	
	    #declare local_clock = 0.5*(clock - 10); 
	    
	    #declare sphere_1_t = off_glass_transmission_coeff;
	    #declare sphere_2_t = off_glass_transmission_coeff; 
	    #declare sphere_3_t = off_glass_transmission_coeff;  
	    #declare sphere_4_t = off_glass_transmission_coeff; 
	    #declare ring_12_th = 1/3;
	    #declare ring_12_t = off_transmission;
	    #declare ring_23_th = 1/3;
	    #declare ring_23_t = off_transmission;
	    #declare ring_13_th = 1/3;
	    #declare ring_13_t = off_transmission;
	
		#declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7;
		#declare sphere_3_radius = 7;
		#declare sphere_4_radius = 10;  
		
		#declare ring_14_th = 1/3;
	    #declare ring_14_t = off_transmission;
	    #declare ring_24_th = 1/3;
	    #declare ring_24_t = off_transmission;
	    #declare ring_34_th = 1/3;
	    #declare ring_44_t = off_transmission;   
	    
	    //rotateion of the camera to the opposite point, next the earth will be inserted
	    //the rotation will be of 180 degrees 
	    #declare x_camera = 25*sin(pi*local_clock + pi/2);
	    #declare z_camera = -25*cos(pi*local_clock);
	    #declare y_camera = sqrt(40.0166*40.0166 - x_camera*x_camera -z_camera*z_camera);
	    camera
            { 
              location <x_camera, y_camera, z_camera>
              look_at <15/4+sqrt(167)/4,0,15/4-sqrt(167)/4>
              right x*image_width/image_height
            }
	#break
	
	#range(12,13)
	
	    //fade in of the earth and of all of the circles
	
	    #declare local_clock = (clock - 12); 
	    
	    #declare sphere_1_t = off_glass_transmission_coeff;
	    #declare sphere_2_t = off_glass_transmission_coeff; 
	    #declare sphere_3_t = off_glass_transmission_coeff;  
	    #declare sphere_4_t = off_glass_transmission_coeff; 
	    #declare ring_12_th = 1/3;
	    #declare ring_12_t = 1 - (local_clock);
	    #declare ring_23_th = 1/3;
	    #declare ring_23_t = 1 - (local_clock);
	    #declare ring_13_th = 1/3;
	    #declare ring_13_t = 1 - (local_clock);
	
		#declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7;
		#declare sphere_3_radius = 7;
		#declare sphere_4_radius = 10;  
		
		#declare ring_14_th = 1/3;
	    #declare ring_14_t = 1 - (local_clock);
	    #declare ring_24_th = 1/3;
	    #declare ring_24_t = 1 - (local_clock);
	    #declare ring_34_th = 1/3;
	    #declare ring_44_t = 1 - (local_clock);   
	    
	    camera
            { 
              location <-25, 25, 25>
              look_at <15/4+sqrt(167)/4,0,15/4-sqrt(167)/4>
              right x*image_width/image_height
            } 
            
        #declare r_earth =  6.378*(local_clock);
	#break 
	
	#range(13,14)
	
	    //fade out all the spheres, bring their reflection coefficent 0 too
	
	    #declare local_clock = (clock - 13); 
	    
	    #declare sphere_1_t = off_glass_transmission_coeff + 0.1*local_clock;
	    #declare sphere_2_t = off_glass_transmission_coeff + 0.1*local_clock; 
	    #declare sphere_3_t = off_glass_transmission_coeff + 0.1*local_clock;  
	    #declare sphere_4_t = off_glass_transmission_coeff + 0.1*local_clock;   
	    #declare glass_reflection = 0.1- 0.01*local_clock;
	    #declare ring_12_th = 1/3;
	    #declare ring_12_t = on_glass_transmission_coeff;
	    #declare ring_23_th = 1/3;
	    #declare ring_23_t = on_glass_transmission_coeff;
	    #declare ring_13_th = 1/3;
	    #declare ring_13_t = on_glass_transmission_coeff;
	
		#declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7;
		#declare sphere_3_radius = 7;
		#declare sphere_4_radius = 10;  
		
		#declare ring_14_th = 1/3;
	    #declare ring_14_t = on_glass_transmission_coeff;
	    #declare ring_24_th = 1/3;
	    #declare ring_24_t = on_glass_transmission_coeff;
	    #declare ring_34_th = 1/3;
	    #declare ring_44_t = on_glass_transmission_coeff;   
	    
	    camera
            { 
              location <-25, 25, 25>
              look_at <15/4+sqrt(167)/4,0,15/4-sqrt(167)/4>
              right x*image_width/image_height
            } 
            
        #declare r_earth =  6.378;
	#break  
	
	#range(14,16)
	
	    //fade out all the spheres, bring their reflection coefficent 0 too
	
	    #declare local_clock = (clock - 14); 
	    
	    #declare sphere_1_t = 1;
	    #declare sphere_2_t = 1; 
	    #declare sphere_3_t = 1;  
	    #declare sphere_4_t = 1;   
	    #declare glass_reflection = 0;
	    #declare ring_12_th = 1/3;
	    #declare ring_12_t = on_glass_transmission_coeff;
	    #declare ring_23_th = 1/3;
	    #declare ring_23_t = on_glass_transmission_coeff;
	    #declare ring_13_th = 1/3;
	    #declare ring_13_t = on_glass_transmission_coeff;
	
		#declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7;
		#declare sphere_3_radius = 7;
		#declare sphere_4_radius = 10;  
		
		#declare ring_14_th = 1/3;
	    #declare ring_14_t = on_glass_transmission_coeff;
	    #declare ring_24_th = 1/3;
	    #declare ring_24_t = on_glass_transmission_coeff;
	    #declare ring_34_th = 1/3;
	    #declare ring_44_t = on_glass_transmission_coeff;   
	     	              
        #declare r_earth =  6.378;    
        
        #declare x_camera = -25*sin(pi*0.5*local_clock + pi/2);
	    #declare z_camera = +25*cos(pi*0.5*local_clock);
	    #declare y_camera = sqrt(40.0166*40.0166 - x_camera*x_camera -z_camera*z_camera);
	    camera
            { 
              location <x_camera, z_camera, y_camera>
              look_at <15/4+sqrt(167)/4,0,15/4-sqrt(167)/4>
              right x*image_width/image_height
            }
	#break
	
	#range(16,18)
	
	    //fade all out, conclude the animation
	
	    #declare local_clock = 0.5*(clock - 16); 
	    
	    #declare sphere_1_t = 1;
	    #declare sphere_2_t = 1; 
	    #declare sphere_3_t = 1;  
	    #declare sphere_4_t = 1;   
	    #declare glass_reflection = 0;
	    #declare ring_12_th = 1/3;
	    #declare ring_12_t = local_clock;
	    #declare ring_23_th = 1/3;
	    #declare ring_23_t = local_clock;
	    #declare ring_13_th = 1/3;
	    #declare ring_13_t = local_clock;
	
		#declare sphere_1_radius = 7;
		#declare sphere_2_radius = 7;
		#declare sphere_3_radius = 7;
		#declare sphere_4_radius = 10;  
		
		#declare ring_14_th = 1/3;
	    #declare ring_14_t = local_clock;
	    #declare ring_24_th = 1/3;
	    #declare ring_24_t = local_clock;
	    #declare ring_34_th = 1/3;
	    #declare ring_44_t = local_clock;   
	     	              
        #declare r_earth =  6.378*(1-local_clock);  
        
        #declare transmit_point = local_clock;    
        
        #declare x_camera = -25*sin(pi + pi/2);
	    #declare z_camera = +25*cos(pi);
	    #declare y_camera = sqrt(40.0166*40.0166 - x_camera*x_camera -z_camera*z_camera);
	    camera
            { 
              location <x_camera, z_camera, y_camera>
              look_at <15/4+sqrt(167)/4,0,15/4-sqrt(167)/4>
              right x*image_width/image_height
            } 
        
 
	#break
	
	
    
#end


//we have many objects in the scene, they are also transparent
//the transparency is a needed feature we need it top show the different, not uniques, solutions
//hence we need to have a pretty good lighting in the scene 
#declare n_lights = 8;
#declare phi_lights = -90;

#for(i, 0, n_lights)
	light_source
	{
		y*+40
		color White
		translate z*40
		rotate y*(i*360/n_lights - phi_lights)
	}
#end         
       
       
//this section is needed to display three arrows where the coordinates system usually is       
#declare arrow_length = 10;
      
#declare arrow =
union
{
	cylinder { -y * arrow_length, 0, 0.5 }
	cone { 0, 1, y * arrow_length/3, 0 }
	translate y * arrow_length
}
   
   
//this object is used as an helper to define teh coordinates system
#declare indicator = 
union
{
	object {arrow}
	
}

#declare yaw =
object
{
	indicator
	pigment { rgb<1,0,0> transmit 0.2}
	finish { reflection .2 }
}

#declare roll =
object
{
	indicator
	rotate z*-90
	pigment { rgb<0,0,1> transmit 0.2}
	finish { reflection .2 }
}

#declare pitch =
object
{
	indicator
	rotate x*-90
	pigment { rgb<0,1,0> transmit 0.2}
	finish { reflection .2 }
}
       
     
//coordinates system object 
/* 
union
{
	object { pitch }
	object { roll }
	object { yaw }
	
}  
*/   

//this was a bad choice, maybe something darker and less reflective, will maybe come back on it in the feature
/*   
plane
{
	y, -25
	pigment { rgb <.7,.95,1> }
	finish { specular .5 reflection .2 }
}  

*/ 

//it can be introduced afterwards
// Earth 
sphere
{
	<0,0,0> r_earth
	texture	{ pigment{ image_map { png "earth.png" map_type 1 }} } 
	scale<1.03,1,1.03>
	//rotate y*(-70+clock*5)    
	rotate y*100
	rotate z*-40
	translate <15/4+sqrt(167)/4, 0, 0.52-6.37>
}                  

 

// GPS signal spheres 
//point, position of GPS-receiver       

sphere
{
	<15/4+sqrt(167)/4,0,15/4-sqrt(167)/4> 0.75
	pigment { rgb<1,69/255,0> transmit transmit_point}
	finish { reflection 0.1 }  
	interior{ior 1}

}   

   
//sphere 1, red  
//this is a test --->let the sphere expand
sphere
{
	<5,5,5> sphere_1_radius
	pigment { rgb<1,0,0> transmit sphere_1_t}
	finish { reflection glass_reflection }  
	interior{ior glass_ior}

} 

//sphere 2, green     
sphere
{
	<5,-5,5> sphere_2_radius
	pigment { rgb<0,1,0> transmit sphere_2_t} //0.7
	finish { reflection glass_reflection }  
	interior{ior glass_ior}

}  
 
//first ring, intersection between spheres 1 and 2
torus
{       
    5, ring_12_th
	pigment { rgb<0,0,1> transmit ring_12_t}
	finish { reflection ring_12_r }
	translate <5, 0, 5> 
}   


//sphere 3, orange          
sphere
{
	<0,0,0> sphere_3_radius
	pigment { rgb<1,69/255,0> transmit sphere_3_t}
	finish { reflection glass_reflection }  
	interior{ior glass_ior}

}  

//ring, intersection between sphere 2 and 3 
torus
{       
    5.5, ring_23_th
	pigment { rgb<0,0,1> transmit ring_23_t}
	finish { reflection ring_23_r }
	rotate <+35, 0, -45>
	translate <2.5, 2.5, 2.5>
}  



//ring, intersection between sphere 1 and 3

torus
{       
    5.5, ring_13_th
	pigment { rgb<0,0,1> transmit ring_13_t}
	finish { reflection ring_13_r }
	rotate <-35, 0, -135+180>
	translate <2.5, -2.5, 2.5>
}  
      
 
//sphere 4, light blue          
sphere
{
	<15/4+sqrt(167)/4,0,15/4-sqrt(167)/4 +10 > sphere_4_radius
	pigment { rgb<45/255,100/255,245/255> transmit sphere_4_t}
	finish { reflection glass_reflection }  
	interior{ior glass_ior}

}      

//ring, intersection between sphere 4 and 3
torus
{       
    5.53, ring_34_th
	pigment { rgb<0,0,1> transmit ring_34_t}
	finish { reflection ring_34_r }
	rotate <+56, 0, -90>
	translate <2.37 , 0 , 3.58>
} 
   
//ring, intersection between sphere 4 and 1
torus
{       
    7, ring_14_th
	pigment { rgb<0,0,1> transmit ring_14_t}
	finish { reflection ring_14_r }
	rotate <-47.85, 0, -70.255+180-90>//<+47.85, +90, +70.2548>
	translate <5.14 , 4.65 , 5.39>
} 
 
//ring, intersection between sphere 4 and 2 
torus
{       
    7, ring_24_th
	pigment { rgb<0,0,1> transmit ring_24_t}
	finish { reflection ring_24_r }
	rotate <-47.85, 0, -70.255+180+45>//<+47.85, +90, +70.2548>
	translate <5.14 , -4.65 , 5.39>
} 
          

// Sky
sky_sphere
{
	pigment
	{
		crackle form <1,1,0> color_map { [.3 rgb 1] [.4 rgb 0] }
		scale sky_scale
	}
}
 

