Required environement: MATLAB 2019 or upper

simulate the files sequencially from s1 to s6

s1 file is for turbine maximum power tracking curve 
s2 generates the wind velocity and dump the corresponding torque output of turbine in Tm.mat file
s3 PMSG generator+rectifier dump the rectified output in rectifier.mat
s4 input dependent boost converter rises the DC to a fixed higher voltage
s5 inverter converts the PMSG output to 5oHz AC andsupplied to load
s6 HESG with fuzzy logic controller for output voltage control only. takes torque as input from Tm.mat file 
	the fuzzy logic block need a fis file which contains input output defination and rules. 
	for this project it's VC.fis already loaded to fuzzy block.to change anything in fuzzy block run "fuzzy"
	command from the terminal and import the fis file  