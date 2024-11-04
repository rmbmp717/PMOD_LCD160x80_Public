/*
NISHIHARU
Default option
-top work.PMOD_LCD_top_dsimtest -L dut +acc+b -waves wave.vcd
*/
`timescale 1ns / 1ps
module PMOD_LCD_top_dsimtest ();

`define RTLSIM

reg clk = 0;
reg rst_n, sw_rstn;
integer error_cnt = 0;

PMOD_LCD_top mPMOD_LCD_top(
    .clk                (0),
    .rst_n              (rst_n), 
    .sw_rstn            (sw_rstn),
    .led                (),
    .LCD_RSTX           (RSTX),
    .LCD_CSX            (CSX),
    .LCD_DC             (DC),
    .LCD_SDA            (SDA),            // SDA : inout
    .LCD_SCK            (SCK),
    .LCD_NC1            (NC1), 
    .LCD_NC2            (NC2), 
    .LCD_NC3            (NC3) 
    `ifdef RTLSIM
    ,.clk_10MHz         (clk)
    `endif
);

initial begin
    forever begin
        #5;
        clk = 1;
        #5;
        clk = 0;
    end
end

initial begin
    rst_n = 0;
    sw_rstn = 0;
    #100
    rst_n = 1;
    sw_rstn = 1;
    #500
    sw_rstn = 0;        // 1 time
    #100
    sw_rstn = 1;
    #30000
    sw_rstn = 0;        // 2 time
    #100
    sw_rstn = 1;
    #30000
    sw_rstn = 0;        // 3 time
    #100
    sw_rstn = 1;
    #30000
    sw_rstn = 0;        // 4 time
    #100
    sw_rstn = 1;
    #30000
    sw_rstn = 0;        // 5 time
    #100
    sw_rstn = 1;
    #30000
    sw_rstn = 0;        // 6 time
    #100
    sw_rstn = 1;
    #50000
    sw_rstn = 0;        // 7 time
    #100
    sw_rstn = 1;
    #50000
    sw_rstn = 0;        // 8 time
    #100
    sw_rstn = 1;
    #30000
    sw_rstn = 0;        // 9 time
    #100
    sw_rstn = 1;
    /*
    #100000
    sw_rstn = 0;        // 10 time
    #100
    sw_rstn = 1;
    #30000
    sw_rstn = 0;        // 11 time
    #100
    sw_rstn = 1;
    #30000
    sw_rstn = 0;        // 12 time
    #100
    sw_rstn = 1;
    */
    
    #1000000
    $display("finish");
    $finish();
end

always @(mPMOD_LCD_top.lcd_controller.H_pos) begin
    $display("H_pos =", mPMOD_LCD_top.lcd_controller.H_pos);
    $display("V_pos =", mPMOD_LCD_top.lcd_controller.V_pos);
end

endmodule
