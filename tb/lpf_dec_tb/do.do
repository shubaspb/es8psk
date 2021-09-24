
vlib work

set dir "../../src/es8psk_rec/" 
set dir_lib "../../../dspb/" 

#vlog -sv {*}$dir/package_dpd.svh +incdir+$dir

vlog -mfcu\
{*}$dir/lpf_dec.v\
{*}$dir_lib/ddc_duc_cordic.v\
{*}$dir_lib/cic_filter.v\
{*}$dir_lib/delay_rg.v\
{*}$dir/fir_filter.v\
lpf_dec_tb.sv\
+incdir+$dir

vsim -voptargs=+acc work.lpf_dec_tb



################ macros ##########################################################################
set bin "add wave -color Green"
set lit "add wave -color Green -literal -height 2"
set dec "add wave -color Green -literal -height 2 -radix decimal"
set s12 "add wave -color Green -analog -min -2047 -max 2047 -height 100 -radix decimal"
set s16 "add wave -color Green -analog -min -32767 -max 32767 -height 100 -radix decimal"
set s18 "add wave -color Green -analog -min -128000 -max 128000 -height 100 -radix decimal"
set u18 "add wave -color Green -analog -min 0 -max 262144 -height 100 -radix decimal"
set s20 "add wave -color Green -analog-interpolated -min -524287 -max 524287 -height 100 -radix decimal"
set u19 "add wave -color Green -analog-interpolated -min 0 -max 520575 -height 600 -radix unsigned"
set u20 "add wave -color Green -analog-interpolated -min 0 -max 1048575 -height 100 -radix unsigned"
set u32 "add wave -color Green -analog-interpolated -min 0 -max 4294967296 -height 100 -radix unsigned"
set s22 "add wave -color Green -analog-interpolated -min -2097148 -max 2097148 -height 100 -radix decimal"
set s24 "add wave -color Green -analog-interpolated -min -8388607 -max 8388607 -height 100 -radix decimal"
set u24 "add wave -color Green -analog-interpolated -min 0 -max 16388607 -height 100 -radix decimal"
set s32 "add wave -color Green -analog-interpolated -min -1000000000 -max 1000000000 -height 50 -radix decimal"
##################################################################################################



{*}$u32 lpf_dec_tb/cnt_freq
{*}$s20 lpf_dec_tb/sig_in_i
{*}$s20 lpf_dec_tb/sig_in_q
{*}$s20 lpf_dec_tb/sig_out_i
{*}$s20 lpf_dec_tb/sig_out_q


run 400 us