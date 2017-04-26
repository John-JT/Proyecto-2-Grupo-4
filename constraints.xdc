## Clock signal
##Bank = 35, Pin name = IO_L12P_T1_MRCC_35,					Sch name = CLK100MHZ
set_property PACKAGE_PIN E3 [get_ports reloj]							
set_property IOSTANDARD LVCMOS33 [get_ports reloj]
create_clock -add -name reloj -period 10.00 -waveform {0 5} [get_ports reloj]
 

## Switches
##Bank = 34, Pin name = IO_L21P_T3_DQS_34,					Sch name = SW0
set_property PACKAGE_PIN U9 [get_ports F_H]					
set_property IOSTANDARD LVCMOS33 [get_ports F_H]
##Bank = 34, Pin name = IO_25_34,							Sch name = SW1
set_property PACKAGE_PIN U8 [get_ports P_HORA]					
set_property IOSTANDARD LVCMOS33 [get_ports P_HORA]
##Bank = 34, Pin name = IO_L23P_T3_34,						Sch name = SW2
set_property PACKAGE_PIN R7 [get_ports P_FECHA]					
set_property IOSTANDARD LVCMOS33 [get_ports P_FECHA]
##Bank = 34, Pin name = IO_L19P_T3_34,						Sch name = SW3
set_property PACKAGE_PIN R6 [get_ports P_CRONO]					
set_property IOSTANDARD LVCMOS33 [get_ports P_CRONO]
##Bank = 34, Pin name = IO_L19N_T3_VREF_34,					Sch name = SW4
set_property PACKAGE_PIN R5 [get_ports A_A]					
set_property IOSTANDARD LVCMOS33 [get_ports A_A]
##Bank = 34, Pin name = IO_L20P_T3_34,						Sch name = SW5
set_property PACKAGE_PIN V7 [get_ports R_RTC]					
set_property IOSTANDARD LVCMOS33 [get_ports R_RTC]


##Buttons
##Bank = 15, Pin name = IO_L11N_T1_SRCC_15,					Sch name = BTNC
set_property PACKAGE_PIN E16 [get_ports resetM]						
set_property IOSTANDARD LVCMOS33 [get_ports resetM]
##Bank = 15, Pin name = IO_L14P_T2_SRCC_15,					Sch name = BTNU
set_property PACKAGE_PIN F15 [get_ports SUMAR]						
set_property IOSTANDARD LVCMOS33 [get_ports SUMAR]
##Bank = CONFIG, Pin name = IO_L15N_T2_DQS_DOUT_CSO_B_14,	Sch name = BTNL
set_property PACKAGE_PIN T16 [get_ports IZQUIERDA]						
set_property IOSTANDARD LVCMOS33 [get_ports IZQUIERDA]
##Bank = 14, Pin name = IO_25_14,							Sch name = BTNR
set_property PACKAGE_PIN R10 [get_ports DERECHA]						
set_property IOSTANDARD LVCMOS33 [get_ports DERECHA]
##Bank = 14, Pin name = IO_L21P_T3_DQS_14,					Sch name = BTND
set_property PACKAGE_PIN V10 [get_ports RESTAR]						
set_property IOSTANDARD LVCMOS33 [get_ports RESTAR]
 
##VGA Connector
##Bank = 35, Pin name = IO_L8N_T1_AD14N_35,					Sch name = VGA_R0
set_property PACKAGE_PIN A3 [get_ports {R[0]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {R[0]}]
##Bank = 35, Pin name = IO_L7N_T1_AD6N_35,					Sch name = VGA_R1
set_property PACKAGE_PIN B4 [get_ports {R[1]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {R[1]}]
##Bank = 35, Pin name = IO_L1N_T0_AD4N_35,					Sch name = VGA_R2
set_property PACKAGE_PIN C5 [get_ports {R[2]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {R[2]}]
##Bank = 35, Pin name = IO_L8P_T1_AD14P_35,					Sch name = VGA_R3
set_property PACKAGE_PIN A4 [get_ports {R[3]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {R[3]}]

##Bank = 35, Pin name = IO_L2P_T0_AD12P_35,					Sch name = VGA_B0
set_property PACKAGE_PIN B7 [get_ports {B[0]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {B[0]}]
##Bank = 35, Pin name = IO_L4N_T0_35,						Sch name = VGA_B1
set_property PACKAGE_PIN C7 [get_ports {B[1]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {B[1]}]
##Bank = 35, Pin name = IO_L6N_T0_VREF_35,					Sch name = VGA_B2
set_property PACKAGE_PIN D7 [get_ports {B[2]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {B[2]}]
##Bank = 35, Pin name = IO_L4P_T0_35,						Sch name = VGA_B3
set_property PACKAGE_PIN D8 [get_ports {B[3]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {B[3]}]

##Bank = 35, Pin name = IO_L1P_T0_AD4P_35,					Sch name = VGA_G0
set_property PACKAGE_PIN C6 [get_ports {G[0]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {G[0]}]
##Bank = 35, Pin name = IO_L3N_T0_DQS_AD5N_35,				Sch name = VGA_G1
set_property PACKAGE_PIN A5 [get_ports {G[1]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {G[1]}]
##Bank = 35, Pin name = IO_L2N_T0_AD12N_35,					Sch name = VGA_G2
set_property PACKAGE_PIN B6 [get_ports {G[2]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {G[2]}]
##Bank = 35, Pin name = IO_L3P_T0_DQS_AD5P_35,				Sch name = VGA_G3
set_property PACKAGE_PIN A6 [get_ports {G[3]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {G[3]}]

##Bank = 15, Pin name = IO_L4P_T0_15,						Sch name = VGA_HS
set_property PACKAGE_PIN B11 [get_ports H_Syncreg]						
set_property IOSTANDARD LVCMOS33 [get_ports H_Syncreg]
##Bank = 15, Pin name = IO_L3N_T0_DQS_AD1N_15,				Sch name = VGA_VS
set_property PACKAGE_PIN B12 [get_ports V_Syncreg]						
set_property IOSTANDARD LVCMOS33 [get_ports V_Syncreg]



##Pmod Header JA
##Bank = 15, Pin name = IO_L1N_T0_AD0N_15,					Sch name = JA1
set_property PACKAGE_PIN B13 [get_ports {DIR_DATO[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {DIR_DATO[0]}]
##Bank = 15, Pin name = IO_L5N_T0_AD9N_15,					Sch name = JA2
set_property PACKAGE_PIN F14 [get_ports {DIR_DATO[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {DIR_DATO[1]}]
##Bank = 15, Pin name = IO_L16N_T2_A27_15,					Sch name = JA3
set_property PACKAGE_PIN D17 [get_ports {DIR_DATO[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {DIR_DATO[2]}]
##Bank = 15, Pin name = IO_L16P_T2_A28_15,					Sch name = JA4
set_property PACKAGE_PIN E17 [get_ports {DIR_DATO[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {DIR_DATO[3]}]
##Bank = 15, Pin name = IO_0_15,								Sch name = JA7
set_property PACKAGE_PIN G13 [get_ports {DIR_DATO[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {DIR_DATO[4]}]
##Bank = 15, Pin name = IO_L20N_T3_A19_15,					Sch name = JA8
set_property PACKAGE_PIN C17 [get_ports {DIR_DATO[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {DIR_DATO[5]}]
##Bank = 15, Pin name = IO_L21N_T3_A17_15,					Sch name = JA9
set_property PACKAGE_PIN D18 [get_ports {DIR_DATO[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {DIR_DATO[6]}]
##Bank = 15, Pin name = IO_L21P_T3_DQS_15,					Sch name = JA10
set_property PACKAGE_PIN E18 [get_ports {DIR_DATO[7]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {DIR_DATO[7]}]

##Pmod Header JB
##Bank = 15, Pin name = IO_L15N_T2_DQS_ADV_B_15,				Sch name = JB1
set_property PACKAGE_PIN G14 [get_ports CS]					
set_property IOSTANDARD LVCMOS33 [get_ports CS]
##Bank = 14, Pin name = IO_L13P_T2_MRCC_14,					Sch name = JB2
set_property PACKAGE_PIN P15 [get_ports RD]					
set_property IOSTANDARD LVCMOS33 [get_ports RD]
##Bank = 14, Pin name = IO_L21N_T3_DQS_A06_D22_14,			Sch name = JB3
set_property PACKAGE_PIN V11 [get_ports WR]					
set_property IOSTANDARD LVCMOS33 [get_ports WR]
##Bank = CONFIG, Pin name = IO_L16P_T2_CSI_B_14,				Sch name = JB4
set_property PACKAGE_PIN V15 [get_ports A_D]					
set_property IOSTANDARD LVCMOS33 [get_ports A_D]
##Bank = 15, Pin name = IO_25_15,							Sch name = JB7
set_property PACKAGE_PIN K16 [get_ports {Control[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {Control[0]}]
##Bank = CONFIG, Pin name = IO_L15P_T2_DQS_RWR_B_14,			Sch name = JB8
set_property PACKAGE_PIN R16 [get_ports {Control[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {Control[1]}]
##Bank = 14, Pin name = IO_L24P_T3_A01_D17_14,				Sch name = JB9
set_property PACKAGE_PIN T9 [get_ports act_crono]					
set_property IOSTANDARD LVCMOS33 [get_ports act_crono]
##Bank = 14, Pin name = IO_L19N_T3_A09_D25_VREF_14,			Sch name = JB10 
set_property PACKAGE_PIN U11 [get_ports PULSE]					
set_property IOSTANDARD LVCMOS33 [get_ports PULSE]
 
 
 ##Pmod Header JC
##Bank = 35, Pin name = IO_L23P_T3_35,						Sch name = JC1
set_property PACKAGE_PIN K2 [get_ports {psi[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {psi[0]}]
##Bank = 35, Pin name = IO_L6P_T0_35,						Sch name = JC2
set_property PACKAGE_PIN E7 [get_ports {psi[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {psi[1]}]
##Bank = 35, Pin name = IO_L22P_T3_35,						Sch name = JC3
set_property PACKAGE_PIN J3 [get_ports {psi[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {psi[2]}]
 
 
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

