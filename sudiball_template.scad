
// design parameters

planes=3;       //  3,4...   (2 for a dob like rockers)
tilt=9;        // +/- angles in degrees (zero for Chuck & Davids) 
intersect=-45;  // +/- units from bottom of ball for planes to meet


// ota parameters 
ota_id=30;
F_ratio=3;
thickness=1;
factor=1.5;


////////////////////////
// derived variables
ota_ir=ota_id/2;
ota_or=ota_ir+thickness;  
ball_r=ota_ir*factor;
delta=360/planes;


module sheet (w, t, h, r) {
   translate([0,0,-intersect])
	rotate(a=[tilt,0,r]) 
   translate([0,0,h/2+intersect])
		cube(size=[w,t,h],center=true);
}


difference() {
	intersection() {	
		union(){
		translate([0,0,ball_r])
		 sphere(ball_r,center=true);
			translate([0,0,ball_r])
				 cylinder(r=ota_or,h=F_ratio*ota_id);
		}	
		union(){
			for(rot=[0:delta:360]) 
				sheet(2*ball_r,thickness,4*ball_r, rot);
		}
	}
	translate([0,0,ball_r/2])
		cylinder(r=ota_ir,h=F_ratio*ota_id);
}

// show primay light path
 translate([0,0,ball_r/2]) 
		%cylinder(r=ota_ir,h=F_ratio*ota_id);