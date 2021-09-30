
vlib work

set dir "../../src" 
set dir_lib "../../../dspb" 

vlog -mfcu\
{*}$dir/es8psk_trans/rs_encoder.v\
{*}$dir/es8psk_trans/mod_8psk.v\
{*}$dir/es8psk_trans/gen_message_ext_sq.v\
{*}$dir/es8psk_trans/fir_45.v\
{*}$dir/es8psk_trans/es8psk_trans.v\
{*}$dir/es8psk_rec/corr_preample.v\
{*}$dir/es8psk_rec/find_max_corr.v\
{*}$dir/es8psk_rec/es8psk_rec.v\
{*}$dir/es8psk_rec/decoder_8psk.v\
{*}$dir/es8psk_rec/rs_decoder.v\
{*}$dir/es8psk_rec/ampl_detector.v\
{*}$dir/es8psk_rec/demod_es8psk.v\
{*}$dir/es8psk_rec/lpf_dec.v\
{*}$dir/es8psk_rec/fir_filter.v\
{*}$dir/reed_solomon/RsDecodeChien.v\
{*}$dir/reed_solomon/RsDecodeDegree.v\
{*}$dir/reed_solomon/RsDecodeDelay.v\
{*}$dir/reed_solomon/RsDecodeDpRam.v\
{*}$dir/reed_solomon/RsDecodeErasure.v\
{*}$dir/reed_solomon/RsDecodeEuclide.v\
{*}$dir/reed_solomon/RsDecodeInv.v\
{*}$dir/reed_solomon/RsDecodeMult.v\
{*}$dir/reed_solomon/RsDecodePolymul.v\
{*}$dir/reed_solomon/RsDecodeShiftOmega.v\
{*}$dir/reed_solomon/RsDecodeSyndrome.v\
{*}$dir/reed_solomon/RsDecodeTop.v\
{*}$dir/reed_solomon/RsEncodeTop.v\
{*}$dir_lib/polar_cordic.v\
{*}$dir_lib/ddc_duc_cordic.v\
{*}$dir_lib/delay_rg.v\
{*}$dir_lib/cic_filter.v\
{*}$dir_lib/rf_channel.v\
{*}$dir_lib/lsfr.v\
tester_channel.v\
es_8psk_tb.v\
+incdir+$dir


vsim -voptargs=+acc work.es_8psk_tb


################ macros ############################################################################
set bin "add wave -color Green"
set lit "add wave -color Green -literal -height 2"
set dec "add wave -color Green -literal -height 2 -radix decimal"

set u8 "add wave -color Green -analog -min 0 -max 255 -height 100 -radix unsigned"
set u9 "add wave -color Green -analog -min 0 -max 511 -height 100 -radix unsigned"
set u10 "add wave -color Green -analog -min 0 -max 1023 -height 100 -radix unsigned"
set u12 "add wave -color Green -analog -min 0 -max 4095 -height 100 -radix unsigned"
set u14 "add wave -color Green -analog -min 0 -max 16383 -height 100 -radix unsigned"
set u16 "add wave -color Green -analog -min 0 -max 65535 -height 100 -radix unsigned"
set u18 "add wave -color Green -analog -min 0 -max 262144 -height 100 -radix unsigned"
set u20 "add wave -color Green -analog -min 0 -max 1048575 -height 100 -radix unsigned"
set u24 "add wave -color Green -analog -min 0 -max 16388607 -height 100 -radix unsigned"
set u32 "add wave -color Green -analog -min 0 -max 4294967296 -height 100 -radix unsigned"

set s8 "add wave -color Green -analog -min -256 -max 255 -height 100 -radix decimal"
set s10 "add wave -color Green -analog -min -1024 -max 1023 -height 100 -radix decimal"
set s12 "add wave -color Green -analog -min -4096 -max 4095 -height 100 -radix decimal"
set s14 "add wave -color Green -analog -min -16384 -max 16383 -height 100 -radix decimal"
set s16 "add wave -color Green -analog -min -32767 -max 32767 -height 100 -radix decimal"
set s18 "add wave -color Green -analog -min -128000 -max 128000 -height 100 -radix decimal"
set s20 "add wave -color Green -analog -min -524287 -max 524287 -height 100 -radix decimal"
set s22 "add wave -color Green -analog -min -2097148 -max 2097148 -height 100 -radix decimal"
set s24 "add wave -color Green -analog -min -8388607 -max 8388607 -height 100 -radix decimal"
set s32 "add wave -color Green -analog -min -2000000000 -max 2000000000 -height 100 -radix decimal"
####################################################################################################


{*}$bin es_8psk_tb/ch8psk_rec_inst/ena_data_rx
{*}$lit es_8psk_tb/tester_channel_inst1/data_rx
{*}$lit es_8psk_tb/tester_channel_inst1/data_tx
{*}$lit es_8psk_tb/tester_channel_inst1/rerr
{*}$bin es_8psk_tb/tester_channel_inst1/err_stream
{*}$s16 es_8psk_tb/rf_channel_inst/sig_out_i
{*}$s16 es_8psk_tb/rf_channel_inst/sig_out_q


add wave sim:/es_8psk_tb/ch8psk_rec_inst/*


add wave sim:/es_8psk_tb/ch8psk_rec_inst/lpf_dec_i/fir_filter_inst/*

run 600 us