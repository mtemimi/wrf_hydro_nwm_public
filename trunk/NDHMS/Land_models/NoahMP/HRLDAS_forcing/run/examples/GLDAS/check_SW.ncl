load "$NCARG_ROOT/lib/ncarg/nclex/gsun/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"  

begin

; need to 'setenv NCL_GRIB_PTABLE_PATH ../gribtab.noah.gtb'

lat2print = 400
lon2print = 1200 ;230 ;400;  (400,100) strange (320,720) 0E,20N
yyyy = "2010"
mm = "01"
dd = "02"

infiles = systemfunc("ls /d1/barlage/data/GLDAS/extracted/SWdown24/GLDAS_SWdown."+yyyy+mm+dd+"*.grb")
hr_files = addfiles(infiles,"r")
print(getfilevarnames(hr_files[1]))

hr_rad = new(24,float)
do i = 0,23
 hr_rad(i) = hr_files[i]->SWdown_GDS0_SFC_ave(lat2print,lon2print)
end do
print(hr_rad)

origpath = "/d1/barlage/data/GLDAS/extracted/SWdown/"
sixhr_rad = new(24,float)
infile = addfile(origpath+"GLDAS_SWdown."+yyyy+mm+dd+"00.grb","r")
print(getfilevarnames(infile))
sixhr_rad(0) = infile->SWdown_GDS0_SFC_ave3h(lat2print,lon2print)
infile = addfile(origpath+"GLDAS_SWdown."+yyyy+mm+dd+"03.grb","r")
sixhr_rad(3) = infile->SWdown_GDS0_SFC_ave3h(lat2print,lon2print)
infile = addfile(origpath+"GLDAS_SWdown."+yyyy+mm+dd+"06.grb","r")
sixhr_rad(6) = infile->SWdown_GDS0_SFC_ave3h(lat2print,lon2print)
infile = addfile(origpath+"GLDAS_SWdown."+yyyy+mm+dd+"09.grb","r")
sixhr_rad(9) = infile->SWdown_GDS0_SFC_ave3h(lat2print,lon2print)
infile = addfile(origpath+"GLDAS_SWdown."+yyyy+mm+dd+"12.grb","r")
sixhr_rad(12) = infile->SWdown_GDS0_SFC_ave3h(lat2print,lon2print)
infile = addfile(origpath+"GLDAS_SWdown."+yyyy+mm+dd+"15.grb","r")
sixhr_rad(15) = infile->SWdown_GDS0_SFC_ave3h(lat2print,lon2print)
infile = addfile(origpath+"GLDAS_SWdown."+yyyy+mm+dd+"18.grb","r")
sixhr_rad(18) = infile->SWdown_GDS0_SFC_ave3h(lat2print,lon2print)
infile = addfile(origpath+"GLDAS_SWdown."+yyyy+mm+dd+"21.grb","r")
sixhr_rad(21) = infile->SWdown_GDS0_SFC_ave3h(lat2print,lon2print)
print(sixhr_rad)

print(sum(hr_rad))
print(sum(sixhr_rad))

name = "check_SW"
screen = 1
if(screen.eq.1) then
  wks = gsn_open_wks("x11",name) 
else
  wks = gsn_open_wks("pdf",name) 
end if

time = ispan(0,23,1)
 res2                   = True                     ; plot mods desired
 res2@xyMarkLineModes   = (/"Markers","MarkLines"/)                ; choose which have markers
 res2@xyMonoMarkLineMode= False
 res2@xyMarkers         =  (/16,16/)                      ; choose type of marker  
 res2@xyMarkerColors    = (/"black","red"/)                    ; Marker color
 res2@xyLineColors       = (/"black","red"/)                    ; Marker color
 res2@xyMarkerSizeF     = 0.004                     ; Marker size (default 0.01)

 plot  = gsn_csm_xy (wks,(/time,time/),(/hr_rad,sixhr_rad/),res2) ; create plot

end


