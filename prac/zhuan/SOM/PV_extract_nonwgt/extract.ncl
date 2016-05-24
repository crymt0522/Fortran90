load "/Users/chen/Desktop/prac/hwygroup_ncl_packages/hwygroup.ncl"

begin

fdir = "/Users/chen/Desktop/prac/zhuan/SOM/PV_extract_nonano/"
fdir_ref = "/Users/chen/Desktop/prac/zhuan/SOM/SLP/"
data_id = "300K"

;wks = gsn_open_wks ("pdf",fdir) 
;================= read date =================================
fi = addfile(fdir+"test_pv_300K_NCEP_NCAR_daily_new.nc","r") 
fi_ref = addfile(fdir_ref+"slp_1948-2015.nc","r")

pv = fi->pv_300K(:,{20:85},{90:150})
pv_anom     =   pv

    if_has_leap =   True 
    if_daily    =   True
    yr_str      =   1948
    yr_end      =   2015
    num_yr      =   yr_end-yr_str+1
    

    if(if_has_leap) then
        yyyymmdd    =   yyyymmdd_time(yr_str, yr_end, "integer")
        ;com_date    =   mod(yyyymmdd,10000)
        ;printVarSummary(yyyymmdd)
        ;exit()
    else
        yyyymmdd    =   new(365*num_yr,integer)
        ;com_date    =   new(365*num_yr,integer)
        mon_days    =   (/31,28,31,30,31,30,31,31,30,31,30,31/)
        count = 0
        do i = yr_str,yr_end
        do j = 1, 12
        do k = 1, mon_days(j-1)
            yyyymmdd(count) = i*10000+j*100+k
            ;com_date(count) = j*100+k
            count = count+1
        end do
        end do
        end do
    end if

    if (if_daily) then
        dh  =   1
        real_date   =   yyyymmdd
        com_date    =   mod(real_date,10000) ;mmdd
    else
        dh  =   0.25
        yyyymmddhh  =   new(dimsizes(yyyymmdd)*4, integer)
        do k = 0, dimsizes(yyyymmdd)-1
            yyyymmddhh(k*4)   = yyyymmdd(k)*100 
            yyyymmddhh(k*4+1) = yyyymmdd(k)*100+6 
            yyyymmddhh(k*4+2) = yyyymmdd(k)*100+12
            yyyymmddhh(k*4+3) = yyyymmdd(k)*100+18
        end do
        real_date   =   yyyymmddhh
        com_date    =   mod(real_date,1000000)
    end if

    pv&time =   real_date
    num_time    =   dimsizes(real_date)
             
mm = mod(yyyymmdd/100,100)
dd = mod(yyyymmdd,100)
;print(mm) 

pv_DJF = new((/67*90,dimsizes(pv&lat),dimsizes(pv&lon)/), "float")

it = 0
do k = 90, num_time-1-90
  ;print(mm(k))
  if( (mm(k) .eq. 12) .or. (mm(k) .eq. 1) .or. (mm(k) .eq. 2) )
    if (.not. ( (mm(k) .eq. 2) .and. (dd(k) .eq.29)))
        pv_DJF(it,:,:) = pv(k,:,:)
        it = it+1
        print("mm: "+mm(k)+" dd: "+dd(k))
    end if 
  end if 
end do 
print("it: "+it)

printMinMax(pv_DJF, True)
;=============== file IO ==============================
fiout         =   addfile(fdir+"pv_DJF_"+data_id+".nc","c")
fiout->pv           =   pv_DJF



end