/*
NISHIHARU
*/
`define RTLSIM
`define DUMPFILE

module PMOD_LCD_top (
    input wire          clk,
    input wire          rst_n, 
    input wire          sw_rstn,
    output wire [7:0]   led,
    output wire         LCD_RSTX,
    output wire         LCD_CSX,
    output wire         LCD_DC,
    inout  wire         LCD_SDA,            // SDA : inout
    output wire         LCD_SCK,
    output wire         LCD_NC1, 
    output wire         LCD_NC2, 
    output wire         LCD_NC3 
    `ifdef RTLSIM
    ,input wire         clk_10MHz
    `endif
);

    `ifdef RTLSIM
    // TBD
    `endif

    `ifdef DUMPFILE    
    initial begin
        $dumpfile("waveform.vcd");  // VCDファイルの名前を指定
        $dumpvars(0, PMOD_LCD_top);  // ダンプする階層を指定
    end
    `endif

    //##########################################################################################

    wire LCD_SDA_Read;
    wire LCD_SDA_out;

    assign LCD_SDA = (~LCD_SDA_Read)? LCD_SDA_out : 1'bz;

    //##########################################################################################
    
    wire [3:0]  cmd_num_out;
    wire [7:0]  frame_state;

    //assign led = 8'b0101_0101;
    //assign led = {{cmd_num_out},{frame_state[3:0]}};
    assign led = ~frame_state;
    //assign led[0] = LCD_SDA;

    //##########################################################################################
    `ifndef RTLSIM
    Gowin_PLL mPLL(
        .clkout0    (clk_10MHz),    //output clkout0
        .clkin      (clk)           //input clkin
    );
    `endif

    //##########################################################################################
    // LCD controller
    // LCD : 160x80 pixel

    spi_lcd_controller lcd_controller (
        .clk            (clk_10MHz),
        .rst_n          (rst_n),
        .sw_rstn        (sw_rstn),
        .LCD_CSX        (LCD_CSX),
        .LCD_DC         (LCD_DC),
        .LCD_SDA        (LCD_SDA_out),
        .LCD_SCK        (LCD_SCK),
        .SDA_Read       (LCD_SDA_Read),
        .LCD_RSTX       (LCD_RSTX),
        .H_pos          (),
        .V_pos          (),
        .cmd_num_out    (cmd_num_out),
        .frame_state_out(frame_state)
    );

    // 不使用ピンの設定
    assign LCD_NC1 = 0;
    assign LCD_NC2 = 0;
    assign LCD_NC3 = 0;

endmodule
